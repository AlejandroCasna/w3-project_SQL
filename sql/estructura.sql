-- pasar las premarikey a int. --

ALTER TABLE actor 
    MODIFY COLUMN actor_id INT;
    
    ALTER TABLE category 
    MODIFY COLUMN category_id INT;
    
    ALTER TABLE customer 
    MODIFY COLUMN customer_id INT;
    
    ALTER TABLE film 
    MODIFY COLUMN film_id INT;
    ALTER TABLE film 
    MODIFY COLUMN category_id INT;
    ALTER TABLE film 
    MODIFY COLUMN language_id INT;
    
    ALTER TABLE inventory 
    MODIFY COLUMN inventory_id INT;
     ALTER TABLE inventory 
    MODIFY COLUMN film_id INT;
    
    ALTER TABLE language 
    MODIFY COLUMN language_id INT;
    
    ALTER TABLE old 
    MODIFY COLUMN old_id INT;
    ALTER TABLE old 
    MODIFY COLUMN category_id INT;
    
    ALTER TABLE rental
    MODIFY COLUMN rental_id INT;
    ALTER TABLE rental
    MODIFY COLUMN inventory_id INT;
    ALTER TABLE rental
    MODIFY COLUMN customer_id INT;

-- crear las premary key --

ALTER TABLE actor
ADD PRIMARY KEY (actor_id);

ALTER TABLE film
ADD PRIMARY KEY (film_id);

ALTER TABLE old
ADD PRIMARY KEY (old_id);

ALTER TABLE language
ADD PRIMARY KEY (language_id);

ALTER TABLE category
ADD PRIMARY KEY (category_id);

ALTER TABLE rental
ADD PRIMARY KEY (rental_id);

ALTER TABLE inventory
ADD PRIMARY KEY (inventory_id);


-- crear tabla intermedia --

CREATE TABLE actor_film (
    actor_id INT,
    film_id INT,
    PRIMARY KEY (actor_id, film_id),
    FOREIGN KEY (actor_id) REFERENCES actor(actor_id),
    FOREIGN KEY (film_id) REFERENCES film(film_id)
);

-- Inserción de datos en la tabla actor_film
INSERT INTO actor_film (actor_id, film_id)
SELECT a.actor_id, f.film_id
FROM actor a
JOIN old oh ON a.first_name = oh.first_name AND a.last_name = oh.last_name
JOIN film f ON f.title = oh.title;

-- relacion tabla --
ALTER TABLE film
ADD CONSTRAINT fk_film_language
FOREIGN KEY (language_id) REFERENCES language(language_id);

ALTER TABLE film
ADD CONSTRAINT fk_film_category
FOREIGN KEY (category_id) REFERENCES category(category_id);

ALTER TABLE inventory
ADD CONSTRAINT fk_inventory_film
FOREIGN KEY (film_id) REFERENCES film(film_id);

ALTER TABLE old
ADD CONSTRAINT fk_old_category
FOREIGN KEY (category_id) REFERENCES category(category_id);

ALTER TABLE rental
ADD CONSTRAINT fk_rental_inventory
FOREIGN KEY (inventory_id) REFERENCES inventory(inventory_id);

ALTER TABLE rental
ADD CONSTRAINT fk_rental_customer
FOREIGN KEY (customer_id) REFERENCES customer(customer_id);