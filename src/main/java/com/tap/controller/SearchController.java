package com.tap.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import com.tap.dao.MenuDao;
import com.tap.dao.RestaurantDao;
import com.tap.daoImpl.MenuDaoImpl;
import com.tap.daoImpl.RestaurantDaoImpl;
import com.tap.model.Menu;
import com.tap.model.Restaurant;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/search")
public class SearchController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private MenuDao menuDao;
    private RestaurantDao restaurantDao;

    @Override
    public void init() throws ServletException {
        menuDao = new MenuDaoImpl();
        restaurantDao = new RestaurantDaoImpl();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String q = req.getParameter("q");
        q = (q == null) ? "" : q.trim();

        if (q.length() > 100) {
            q = q.substring(0, 100);
        }

        Map<Integer, String> restaurantNames = new HashMap<>();

        for (Restaurant r : restaurantDao.getAllRestaurants()) {
            restaurantNames.put(r.getRestaurantId(), r.getName());
        }

        List<Menu> results = search(q, restaurantNames);

        // ===== live suggestions (used by the search bar) =====
        if ("json".equals(req.getParameter("format"))) {
            writeJson(resp, results, restaurantNames);
            return;
        }

        // ===== full results page =====
        req.setAttribute("query", q);
        req.setAttribute("searched", !q.isEmpty());
        req.setAttribute("results", results);
        req.setAttribute("restaurantNames", restaurantNames);

        req.getRequestDispatcher("/Search.jsp").forward(req, resp);
    }

    // ---------------------------------------------------------
    //  SEARCH + RELEVANCE
    // ---------------------------------------------------------

    private List<Menu> search(String q, Map<Integer, String> restaurantNames) {

        List<Menu> found = new ArrayList<>();

        if (q.isEmpty()) {
            return found;
        }

        String query = q.toLowerCase();
        String[] tokens = query.split("\\s+");

        Map<Menu, Integer> scores = new HashMap<>();

        for (Menu m : menuDao.getAllMenus()) {
            int s = score(m, query, tokens,
                    restaurantNames.get(m.getRestaurantId()));

            if (s > 0) {
                scores.put(m, s);
                found.add(m);
            }
        }

        found.sort((a, b) -> {
            int diff = scores.get(b) - scores.get(a);
            if (diff != 0) return diff;
            return a.getItemName().compareToIgnoreCase(b.getItemName());
        });

        return found;
    }

    private int score(Menu m, String query, String[] tokens, String restName) {

        String name = m.getItemName() == null ? "" : m.getItemName().toLowerCase();
        String rest = restName == null ? "" : restName.toLowerCase();

        int s = 0;

        if (name.equals(query))                         s = 100;
        else if (name.startsWith(query))                s = 90;
        else if (name.contains(" " + query))            s = 80;
        else if (name.contains(query))                  s = 70;
        else if (allTokens(name, tokens))               s = 60;
        else if (rest.contains(query))                  s = 40;
        else if (allTokens(name + " " + rest, tokens))  s = 30;

        if (s > 5 && !m.isAvailable()) {
            s -= 5;
        }

        return s;
    }

    private boolean allTokens(String text, String[] tokens) {
        for (String t : tokens) {
            if (!text.contains(t)) return false;
        }
        return true;
    }

    // ---------------------------------------------------------
    //  JSON (no library needed)
    // ---------------------------------------------------------

    private void writeJson(HttpServletResponse resp, List<Menu> results,
                           Map<Integer, String> restaurantNames) throws IOException {

        StringBuilder sb = new StringBuilder();
        sb.append("{\"total\":").append(results.size()).append(",\"items\":[");

        int limit = Math.min(results.size(), 6);

        for (int i = 0; i < limit; i++) {
            Menu m = results.get(i);

            if (i > 0) sb.append(",");

            sb.append("{")
              .append("\"menuId\":").append(m.getMenuId())
              .append(",\"restaurantId\":").append(m.getRestaurantId())
              .append(",\"name\":\"").append(json(m.getItemName())).append("\"")
              .append(",\"restaurant\":\"")
              .append(json(restaurantNames.get(m.getRestaurantId()))).append("\"")
              .append(",\"price\":")
              .append(String.format(Locale.US, "%.2f", m.getPrice()))
              .append(",\"image\":\"").append(json(m.getImagePath())).append("\"")
              .append(",\"available\":").append(m.isAvailable())
              .append("}");
        }

        sb.append("]}");

        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        resp.getWriter().write(sb.toString());
    }

    private String json(String s) {
        if (s == null) return "";

        StringBuilder out = new StringBuilder();

        for (char c : s.toCharArray()) {
            switch (c) {
                case '"':  out.append("\\\""); break;
                case '\\': out.append("\\\\"); break;
                case '\n': out.append("\\n");  break;
                case '\r': out.append("\\r");  break;
                case '\t': out.append("\\t");  break;
                default:
                    if (c < 0x20) {
                        out.append(String.format("\\u%04x", (int) c));
                    } else {
                        out.append(c);
                    }
            }
        }

        return out.toString();
    }
}