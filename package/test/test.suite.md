# google-search-console test suite

Run the CI-safe group with `aux4 test run --group core` from this directory. The
`integration` group needs a real Google login and is skipped unless requested.

## core

- google__search-console__query.test.md
- google__search-console__inspect.test.md
- google__search-console__index.test.md
- google__search-console__sites.test.md
- google__search-console__sitemaps.test.md
- google__search-console__injection.test.md

## integration (optional)

- google__search-console.test.md
