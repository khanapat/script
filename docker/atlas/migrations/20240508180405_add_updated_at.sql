-- Modify "repos" table
ALTER TABLE `repos` DROP COLUMN `created_at`, ADD COLUMN `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP;
-- Drop "commits" table
DROP TABLE `commits`;
