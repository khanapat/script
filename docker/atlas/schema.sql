CREATE TABLE `users` (
  `id` bigint,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
);

CREATE TABLE `repos` (
  `id` bigint,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) NULL,
  `owner_id` bigint NOT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  CONSTRAINT `owner_id` FOREIGN KEY (`owner_id`) REFERENCES `users` (`id`)
);