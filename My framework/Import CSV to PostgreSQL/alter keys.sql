ALTER TABLE customers
ADD PRIMARY KEY (customer_id);

ALTER TABLE orders
ADD PRIMARY KEY (order_id);

ALTER TABLE orders
ADD FOREIGN KEY (customer_id) REFERENCES customers (customer_id);

ALTER TABLE stores
ADD PRIMARY KEY (store_id);

ALTER TABLE staffs
ADD PRIMARY KEY (staff_id);

ALTER TABLE orders
ADD CONSTRAINT fk_store
    FOREIGN KEY (store_id) REFERENCES stores (store_id);

ALTER TABLE orders
ADD CONSTRAINT fk_staff
    FOREIGN KEY (staff_id) REFERENCES staffs (staff_id);

ALTER TABLE staffs
ADD CONSTRAINT fk_store
    FOREIGN KEY (store_id) REFERENCES stores (store_id);

ALTER TABLE products
ADD PRIMARY KEY (product_id);

ALTER TABLE stocks
ADD CONSTRAINT fk_product
    FOREIGN KEY (product_id) REFERENCES products (product_id);

ALTER TABLE stocks
ADD CONSTRAINT fk_store
    FOREIGN KEY (store_id) REFERENCES stores (store_id);

ALTER TABLE brands
ADD PRIMARY KEY (brand_id);

ALTER TABLE categories
ADD PRIMARY KEY (category_id);

ALTER TABLE products
ADD CONSTRAINT fk_brand
    FOREIGN KEY (brand_id) REFERENCES brands (brand_id);

ALTER TABLE products
ADD CONSTRAINT fk_category
    FOREIGN KEY (category_id) REFERENCES categories (category_id);

ALTER TABLE order_items
ADD CONSTRAINT fk_product
    FOREIGN KEY (product_id) REFERENCES products (product_id);

ALTER TABLE order_items
ADD CONSTRAINT fk_order
    FOREIGN KEY (order_id) REFERENCES orders (order_id);