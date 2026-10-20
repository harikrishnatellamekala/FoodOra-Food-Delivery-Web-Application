package com.tap.model;

import java.util.LinkedHashMap;
import java.util.Map;

public class Cart {

    private int restaurantId;
    private Map<Integer, CartItem> items;

    public Cart() {
        restaurantId = 0;
        items = new LinkedHashMap<>();
    }

    public int getRestaurantId() {
        return restaurantId;
    }

    public void setRestaurantId(int restaurantId) {
        this.restaurantId = restaurantId;
    }

    public Map<Integer, CartItem> getItems() {
        return items;
    }

    public void setItems(Map<Integer, CartItem> items) {
        this.items = items;
    }

    public boolean addItem(Menu menu) {

        if (items.isEmpty()) {
            restaurantId = menu.getRestaurantId();
        }

        if (restaurantId != menu.getRestaurantId()) {
            return false;
        }

        int menuId = menu.getMenuId();

        if (items.containsKey(menuId)) {

            CartItem existingItem = items.get(menuId);

            existingItem.setQuantity(existingItem.getQuantity() + 1);

        } else {

            CartItem cartItem = new CartItem(menu, 1);

            items.put(menuId, cartItem);
        }

        return true;
    }

    public void updateQuantity(int menuId, int quantity) {

        if (items.containsKey(menuId)) {

            if (quantity > 0) {
                items.get(menuId).setQuantity(quantity);
            } else {
                items.remove(menuId);
            }
        }
    }

    public void removeItem(int menuId) {
        items.remove(menuId);
    }

    public double getTotal() {

        double total = 0;

        for (CartItem cartItem : items.values()) {
            total = total + cartItem.getSubtotal();
        }

        return total;
    }
    
    public void clearCart() {
        items.clear();
        restaurantId = 0;
    }
    
    

    @Override
    public String toString() {
        return "Cart [restaurantId=" + restaurantId + ", items=" + items + "]";
    }
}