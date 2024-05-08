https://atlasgo.io/getting-started/

```bash
# run database
docker run --rm -d --name atlas-demo -p 3306:3306 -e MYSQL_ROOT_PASSWORD=pass -e MYSQL_DATABASE=example mysql

# create table
docker exec atlas-demo mysql -ppass -e 'CREATE table example.users(id int PRIMARY KEY, name varchar(100))'

# inspect
atlas schema inspect -u "mysql://root:pass@localhost:3306/example" > schema.hcl

atlas schema inspect -u "mysql://root:pass@localhost:3306/example" --format '{{ sql . }}' > schema.sql

# apply
atlas schema apply \
  -u "mysql://root:pass@localhost:3306/example" \
  --to file://schema.hcl

atlas schema apply \
  -u "mysql://root:pass@localhost:3306/example" \
  --to file://schema.sql \
  --dev-url "docker://mysql/8/example"

# visualize
atlas schema inspect \
  -u "mysql://root:pass@localhost:3306/example" \
  --web

# versioned migrations
atlas migrate diff create_blog_posts \
  --dir "file://migrations" \
  --to "file://schema.hcl" \
  --dev-url "docker://mysql/8/example"

atlas migrate diff create_blog_posts \
  --dir "file://migrations" \
  --to "file://schema.sql" \
  --dev-url "docker://mysql/8/example"

## initial
atlas migrate diff initial \
  --to "file://schema.sql" \
  --dev-url "docker://mysql/8/example" \
  --format '{{ sql . "  " }}'

## change
atlas migrate diff add_commits \
  --to file://schema.sql \
  --dev-url "docker://mysql/8/example" \
  --format '{{ sql . "  " }}'

atlas migrate diff add_column_created_at \
  --to file://schema.sql \
  --dev-url "docker://mysql/8/example" \
  --format '{{ sql . "  " }}'

atlas migrate diff add_updated_at \
  --to file://schema.sql \
  --dev-url "docker://mysql/8/example" \
  --format '{{ sql . "  " }}'

# create migration from existing database
atlas migrate diff my_baseline \
  --dir "file://migrations" \
  --to "mysql://root:pass@localhost:3306/example"
  --dev-url "docker://mysql/8/example" \

# push migration
atlas migrate push app \
  --dev-url "docker://mysql/8/example"

# apply to database
atlas migrate apply \
  --url "mysql://root:pass@localhost:3306/example" \
  --dir "file://migrations" \
  --baseline "20240508104511"

atlas migrate apply \
  --url "mysql://root:pass@localhost:3306/example" \
  --dir "file://migrations" \
  --allow-dirty

# rollback 1 version
atlas migrate down \
  --url "mysql://root:pass@localhost:3306/example" \
  --dir "file://migrations" \
  --dev-url "docker://mysql/8/example" \
  --dry-run

# rollback with version
atlas migrate down \
  --url "mysql://root:pass@localhost:3306/example" \
  --dir "file://migrations" \
  --dev-url "docker://mysql/8/example" \
  --to-version "20240508174559"
```

```text
schema apply
    --url (-u) is URL of the database to be inspected
    --to is a list of URLs to the desired state
    --dev-url is docker driver to process and validate database

migrate apply
    --url is URL to the database to apply migrations on
    --dir is URL to the migration directory (defaults to file://migrations)

migrate down
    --url is URL to the database to revert the migrations
    --dir is URL to the migration directory (defaults to file://migrations)
    --dev-url is docker driver to process and validate database
    --to-version (optional) the version to revert to
    --to-tag (optional) the directory tag to revert to

migrate diff
    --dir is URL to the migration directory (defaults to file://migrations)
    --to is the URL of the desired state
    --dev-url is docker driver to process and validate database
```
