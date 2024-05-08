-- Modify "repos" table
ALTER TABLE `repos` ADD COLUMN `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP;
