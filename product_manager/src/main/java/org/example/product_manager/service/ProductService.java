package org.example.product_manager.service;

import org.example.product_manager.model.Product;

import java.util.List;

public interface ProductService {
    List<Product> findAll();

    void save(Product product);

    void update(int id, Product product);

    void delete(int id);

    Product findById(int id);
}
