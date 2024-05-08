table "blog_posts" {
  schema = schema.example
  column "id" {
    null = false
    type = int
  }
  column "title" {
    null = true
    type = varchar(100)
  }
  column "body" {
    null = true
    type = text
  }
  column "author_id" {
    null = true
    type = int
  }
  primary_key {
    columns = [column.id]
  }
  foreign_key "author_fk" {
    columns     = [column.author_id]
    ref_columns = [table.users.column.id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
  index "author_fk" {
    columns = [column.author_id]
  }
}
table "repos" {
  schema = schema.example
  column "id" {
    null = false
    type = bigint
  }
  column "name" {
    null = false
    type = varchar(255)
  }
  column "description" {
    null = true
    type = varchar(255)
  }
  column "owner_id" {
    null = false
    type = int
  }
  column = "created_at" {
    null = false
    type = timestamp
  }
  primary_key {
    columns = [column.id]
  }
  foreign_key "owner_id" {
    columns     = [column.owner_id]
    ref_columns = [table.users.column.id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
  index "owner_id" {
    columns = [column.owner_id]
  }
}
table "users" {
  schema = schema.example
  column "id" {
    null = false
    type = int
  }
  column "name" {
    null = true
    type = varchar(100)
  }
  column "wallet" {
    null = false
    type = varchar(20)
  }
  primary_key {
    columns = [column.id]
  }
}
schema "example" {
  charset = "utf8mb4"
  collate = "utf8mb4_0900_ai_ci"
}
