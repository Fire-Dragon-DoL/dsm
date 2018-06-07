# DSM - Database SQL migrations

Utility to run SQL-only migrations.

## Requirements

- [migrate](https://github.com/golang-migrate/migrate) — installed with `setup`
  command (no need to download it), automatically determines the platform
- `bash`
- `curl` or `wget` in `PATH`
- `grep`
- `awk`

## Settings

- `DSM_PROJECT_PATH` _optional_ — Configuration path where migrations are
  located. By default, it's `pwd`
- `DSM_DATABASE_URL` _optional_ — Configuration to connect to the database, it
  follows
  [migrate convention](https://github.com/golang-migrate/migrate/blob/master/database/postgres/README.md)

You can supply a `.dsmrc` file that will be automatically loaded (with `source`
) whenever you run `dsm`.

## Usage

```bash
dsm migrate
```

A migration "version" is the number preceeding the migration title. E.g.:
`1811618032_testme.down.sql` the migration version would be `1811618032`

`dsm COMMAND [OPTIONS]`

- `setup` — Installs the required dependencies and compile `migrate`,
  installing it in `dsm` `build/migrate` path
- `clean` — Uninstalls `migrate` from `build` directory
- `generate` — Creates a new up and down migration following explained
  conventions. A title must be supplied: `dsm generate users` will
  create 2 SQL files ready to be filled. There cannot be 2 migrations with
  same title
- `destroy` — Removes a migration (up and down). A title must be supplied:
  `dsm destroy users` will remove SQL files having title `users`
- `up` — Runs `migrate` with the `up` command, optionally accepting how many
  migrations to run, otherwise **all of the non-applied**
- `down` — Runs `migrate` with the `down` command. Differently from raw `down`
  command on `migrate`, it rollbacks only the latest migration. If a number is
  specified, it will rollback N migrations
- `version` — Runs `migrate` with the `version`, it will report the current
  migration version for the database (the highest migration version run on the
  database)
- `force` — Forces the database to change its own migration version to the
  passed value without actually running any migration, this is useful when
  dealing with dirty states created in development
- `goto` — Migrate the database up to the specified migration version (actually
  runs migrations)
- `migrate` — Runs `migrate` with the given command, but it automatically
  prepends the `-source` option (picks the right directory for migrations) and
  `-database` using environment variables from the [Settings](#settings)

Ideally,`setup` is used only (once), then `generate`, `up` and `down` are used
the rest of the time. A normal workflow for the tool is:

```bash
cd /path/to/directory/for/migrations
dsm setup
dsm generate users
# Fill in xxxx_users.up.sql file
# Fill in xxxx_users.down.sql file
dsm up
```

For further details on commands regarding `migrate`, check the
[migrate README](https://github.com/golang-migrate/migrate)

## Notes

Try to avoid using `migrate` directly, use `dsm` whenever possible.
