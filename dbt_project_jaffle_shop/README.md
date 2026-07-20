# dbt Project

## Purpose

This project is a personal practice environment for building and testing dbt data models locally, without connecting to a cloud data warehouse. It uses the Jaffle Shop dataset (a fictional food delivery company) as the data source.

The goal is to practice the full dbt workflow: loading raw data, building a staging layer, creating fact tables, writing tests, and documenting models.

## Stack

| Tool | Role |
|------|------|
| dbt Core | Transformation and modeling |
| DuckDB | Local data warehouse |

## Project Structure

```
jaffle_shop/
├── seeds/               # Raw CSV data loaded into DuckDB
│   ├── customers.csv
│   ├── orders.csv
│   └── payments.csv
├── models/
│   ├── staging/         # Clean and rename raw data
│   │   ├── stg_customers.sql
│   │   ├── stg_orders.sql
│   │   ├── stg_payments.sql
│   │   └── _staging_schema.yml
│   └── facts/           # Fact tables
│       ├── fct_orders.sql         # Incremental model
│       └── fct_customer_orders.sql
```

## Lineage

```mermaid
flowchart LR
    A[source: customers] --> B[stg_customers]
    C[source: orders] --> D[stg_orders]
    E[source: payments] --> F[stg_payments]

    B --> G[fct_orders]
    D --> G
    F --> G

    G --> I[fct_customer_orders]
```

## Data Model

### Seeds (Raw Data)
- `customers` — one row per customer
- `orders` — one row per order
- `payments` — one row per payment

### Staging Layer
Cleans and renames raw data. No business logic.

- `stg_customers` — renamed columns, primary key test
- `stg_orders` — renamed columns, status accepted values test
- `stg_payments` — renamed columns, amount converted from cents to dollars

### Fact Tables
- `fct_orders` — one row per order, joins customers and payments. Built as an **incremental model** using the merge strategy.
- `fct_customer_orders` — one row per customer, aggregated order metrics (total orders, total spent, first and latest order date)

## Incremental Model Convention

`fct_orders` uses an incremental pattern with a cutoff CTE:

```sql
{% if is_incremental() %}

,incremental_cutoff AS (
    SELECT COALESCE(MAX(order_date), '1900-01-01'::DATE) AS cutoff_date
    FROM {{ this }}
)

{% endif %}
```

The filter is applied as an INNER JOIN on the cutoff CTE, not a WHERE clause.

## How to Run

```bash
# Load raw data
dbt seed

# Build all models
dbt build

# Full refresh (rebuilds incremental models from scratch)
dbt build --full-refresh
```

## What I Practiced

- Setting up a local dbt project with DuckDB
- Building a staging → facts model structure
- Writing incremental models with a merge strategy
- Adding data tests (unique, not_null, accepted_values)
- Documenting models in YAML
- Git workflow (branching, commits, push to GitHub)