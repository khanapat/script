CREATE TABLE company(
    company_id varchar(20) NOT NULL,
    company_name varchar(500) NOT NULL,
    ceo varchar(200) NOT NULL,
    revenue numeric(20, 2) NULL,
    created_by varchar(50) NOT NULL,
    created_at timestamptz NOT NULL DEFAULT NOW(),
    updated_by varchar(50) NOT NULL,
    updated_at timestamptz NOT NULL DEFAULT NOW(),
    deleted_by varchar(50) NULL,
    deleted_at timestamptz NULL,
    id bigserial NOT NULL,
    CONSTRAINT company_pk PRIMARY KEY (company_id)
);

CREATE INDEX company_deleted_at_idx ON company USING btree(deleted_at);

INSERT INTO company(company_id, company_name, ceo, revenue, created_by, created_at, updated_by, updated_at, deleted_by, deleted_at, id)
    VALUES ('C01', 'Apple', 'Tim Cook', 394000000000, 'SYSTEM', '2022-01-12 16:30:00.000', 'SYSTEM', '2023-08-01 18:22:00.000', NULL, NULL, 3);

INSERT INTO company(company_id, company_name, ceo, revenue, created_by, created_at, updated_by, updated_at, deleted_by, deleted_at, id)
    VALUES ('C02', 'Microsoft', 'Satya Nadella', 211000000000, 'SYSTEM', '2022-03-14 21:40:00.000', 'SYSTEM', '2023-06-29 17:40:00.000', NULL, NULL, 4);

INSERT INTO company(company_id, company_name, ceo, revenue, created_by, created_at, updated_by, updated_at, deleted_by, deleted_at, id)
    VALUES ('C03', 'Amazon', 'Andy Jassy', 514000000000, 'SYSTEM', '2022-02-28 15:20:00.000', 'SYSTEM', '2023-07-15 22:55:00.000', NULL, NULL, 5);

INSERT INTO company(company_id, company_name, ceo, revenue, created_by, created_at, updated_by, updated_at, deleted_by, deleted_at, id)
    VALUES ('C04', 'Tesla', 'Elon Musk', 81000000000, 'SYSTEM', '2021-07-01 17:10:00.000', 'SYSTEM', '2023-08-18 00:35:00.000', NULL, NULL, 6);

