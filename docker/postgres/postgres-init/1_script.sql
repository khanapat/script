CREATE TABLE product(
    product_id serial NOT NULL,
    product_code varchar(10) NOT NULL,
    product_name varchar(200) NOT NULL,
    is_active bool NOT NULL DEFAULT TRUE,
    created_by varchar(50) NOT NULL,
    created_at timestamptz DEFAULT now() NOT NULL,
    updated_by varchar(50) NOT NULL,
    updated_at timestamptz DEFAULT now() NOT NULL,
    CONSTRAINT product_pk PRIMARY KEY (product_id)
);

CREATE UNIQUE INDEX product_uk ON product USING btree(product_code)
WHERE (is_active = TRUE);

INSERT INTO product(product_id, product_code, product_name, is_active, created_by, created_at, updated_by, updated_at)
    VALUES (1, 'P001', 'Pencil', TRUE, 'SYSTEM', '2023-01-01 00:00:00.000', 'SYSTEM', '2023-01-01 00:00:00.000'),
(2, 'P002', 'Pen', TRUE, 'SYSTEM', '2023-01-01 00:00:00.000', 'SYSTEM', '2023-01-01 00:00:00.000'),
(3, 'P003', 'Rubber', TRUE, 'SYSTEM', '2023-01-01 00:00:00.000', 'SYSTEM', '2023-01-01 00:00:00.000'),
(4, 'P004', 'Ruler', TRUE, 'SYSTEM', '2023-01-01 00:00:00.000', 'SYSTEM', '2023-01-01 00:00:00.000'),
(5, 'P005', 'Book', FALSE, 'SYSTEM', '2023-01-01 00:00:00.000', 'SYSTEM', '2023-01-01 00:00:00.000');

