# login
`az login`

# show user info
`az account show` - show current user session info

# CLI for terraform
|command|note|
|--|--|
|`terraform init`|download necessary plugins|
|`terraform plan`|plan how final state will look like|
|`terraform apply`|create stuff according my script|
|`terraform destroy`|delete stuff|
|`-auto-approve`|auto approve stuff|

# resource group
`az group delete --name <group_name>` delete group

`az group list`

# networking
`az network nic delete --name vit-net --resource-group my_example_resource`

# seznam vsech linux images pro vytvoreni virtualky
`az vm image list --output table`

# TODO
`terraform refresh`

# run with vara
`terraform plan -var "key=value" -var "key2=value2"`

# TF registry
https://registry.terraform.io

# apply with auto approve
`terraform apply -auto-approve`

----

### Anatomy of a Resource Block
A Terraform resource declaration consists of three primary components:

| Component | Description | Example |
| :--- | :--- | :--- |
| **Block Type** | Defines what kind of block it is. | `resource` |
| **Resource Type** | Defines the specific infrastructure object to be created. | `random_string` |
| **Object Reference** | A custom name used to refer to this resource within your code. | `suffix` |

----

# Version Constraints

| Required Version | Meaning | Considerations | note |
|--|--|--|--|
| 1.7.5 | Only Terraform v1.7.5 exactly | To upgrade Terraform, first edit the required_version setting ||
| >= 1.7.5 | Any Terraform v1.7.5 or greater | Includes Terraform v2.0.0 and above ||
| ~> 1.7.5 | Any Terraform v1.7.x, but not v1.8 or later | Patch version updates should be non-disruptive | probably most used? |
| >= 1.7.5, < 1.9.5 | Terraform v1.7.5 or greater, but less than v1.9.5 | Avoids specific version updates ||

----

## How to input variables
Variable must be already declared as a variable!

### 1. `terraform.tfvars`
- The most common approach
- Used to define values that **don't change across environments**
- Simple and usually sufficient for most use cases

example:
```
load_from_file   = "xyz"
increment_number = 42
```

### 2. `.auto.tfvars`
- Useful when you want **better organization** by grouping different values into separate files
- Any file ending in `.auto.tfvars` is automatically loaded by Terraform (like file `default.auto.tfvars` or `whatever.auto.tfvars`)

### 3. Environment-Specific `.tfvars` Files
- Create a separate file with **any other name** (e.g., `dev.tfvars`) for environment-specific values
- These files are **not loaded automatically** by Terraform
- Must be passed explicitly using the **`--var-file`** command-line option:
  ```
  terraform apply -var-file="dev.tfvars"
  ```
- Without this flag, Terraform will **prompt the user** to manually enter the missing variable values

## How to manage var accros envs

### Approach 1: Add a Naming Prefix

- Add a common prefix to each environment `.tfvars` file — for example, **`env-`**
- This results in files like `env-dev.tfvars`, `env-test.tfvars`, `env-prod.tfvars`
- The prefix **groups them together visually** within the same folder
- Simple to implement with no structural changes required

### Approach 2: Move Files into a Subdirectory

- Create a dedicated subfolder called **`env/`** and place all environment `.tfvars` files inside it
- The prefix is no longer needed (and would be redundant)
- When running `terraform apply`, provide a **relative path** to the file instead of just the filename:
  - Example: point Terraform to `env/prod.tfvars`
- **Benefits:** cleaner root directory, easier to maintain as environments and configurations grow

## Sensitive vars

### Marking Input Variables as Sensitive
- Variables are declared normally, but with a `sensitive = true` flag added
- Without this flag, the value typed at the prompt is **visible in the console**
- With it, the value is **hidden during input** — it is not echoed back to the screen

----

# Data types

## Primitive types

These are the three basic types Terraform supports:

- **`string`** — Text values, declared with double quotes (e.g., `"dev"`, `"Mark's blog"`)
- **`number`** — Numeric values (e.g., `4` for an instance count)
- **`bool`** — Boolean values for toggling things on/off (e.g., `enabled = false`)

## Collection Types

### `list`
- An **ordered** collection of values that **allows duplicates**
- Items are identified by their **index** (zero-based)
- Declared with square brackets: `["west-us", "east-us"]`
- Common use case: declaring supported regions or availability zones
- Access individual items with an index: `var.regions[0]`

### `map`
- A **key-value** structure, similar to a dictionary
- Keys must be **unique**; values are looked up by key
- Declared with curly braces: `{ west-us = 4, east-us = 8 }`
- Common use case: mapping regions to instance counts
- Access values by key: `var.region_instance_count["west-us"]`

### `set`
- Similar in syntax to a list, but **unordered** and **no duplicates**
- Elements have **no index** — they are identified only by their value
- Cannot be accessed with an index or key accessor
- Designed specifically for **iteration** (covered in a future lecture)

## Complex Object Type

- Allows defining a **structured object** with named attributes and their own types
- Declared using `object({ ... })` with attributes defined inside curly braces
- Example: a `sku_settings` object with attributes `kind = string` and `tier = string`
- When passing a value, use curly braces without parentheses: `{ kind = "P", tier = "business" }`
- Attributes are accessed using the **dot operator**: `var.sku_settings.kind`

----

# Validation

### The Validation Block

- Input variable validation is added by placing a **nested `validation` block** inside a `variable` block.
- A nested block is declared like any other block using **curly braces**, but has no block type or object reference name — it is simply called `validation`.
- The `validation` block has **two attributes**:
  - **`condition`** — a required boolean expression; if it evaluates to `false`, a validation error is thrown; if `true`, the value is accepted.
  - **`error_message`** — a string describing the error shown when validation fails.

----

# Comments

3 types

```
# comment 1

// comment 2

/*
comment 3
*/
```

----

# Workspace
workspaces are optional

### Core Workspace Commands
- **`terraform workspace list`** — Lists all workspaces; the currently active one is marked with an **asterisk (`*`)**.
- **`terraform workspace new <name>`** — Creates a new workspace (e.g., `terraform workspace new dev`). Switching to it is done automatically upon creation.
- **`terraform workspace select <name>`** — Switches the active workspace (e.g., back to `default`).

----

# Collection manipulations - TODO

- count, count.index
- length()
- for_each
- ternary operator
- each.key, each.value

----

# Terraform module registry - TODO

----

# Terraform console - TODO

----

# What to study in Azure - TODO

- resource groups
- subscriptions
- Microsoft Entra ID
