<img src="https://github.com/LucBerge/Datafus/raw/master/images/banner_tags.png" />

# Datafus

Datafus is a small python3 tool to build the dofus database by scrapping the website. The final database is a JSON file.

# JSON structure

- `monsters`: List of monsters in the game (1832)
- `weapons`: List of weapons in the game (726)
- `equipments`: List of equipments in the game (2329)
- `sets`: List of sets in the game (331)
- `pets`: List of pets in the game (131)
- `mounts`: List of mounts in the game (142)
- `consumables`: List of consumables in the game (1415)
- `resources`: List of resources in the game (2780)
- `ceremonial_items`: List of ceremonial items in the game (711)
- `sidekicks`: List of sidekicks items in the game (12)
- `idols`: List of idols in the game (89)
- `harnesses`: List of harnesses in the game (63)

## Item structure
_The following fields are always existing_

- `url`: The item url
- `id`: The item id
- `img`: The item image url
- `type`: The item type

### Monsters
_Only for monsters_

- `level`: String representing the range level 
- `characteristics`: List of string characteristics
- `resistances`: List of string resistances

### Weapons
_Only for weapons_

- `level`: Weapon level
- `description`: Weapon description
- `effects` (optional): List of string effects
- `conditions` (optional): List of string conditions
- `characteristics`: List of string characteristics
- `craft` (optional): How to craft the weapon

### Equipments
_Only for equipments_

- `level`: Equipment level
- `description`: Equipment description
- `effects` (optional): List of string effects
- `conditions` (optional): List of string conditions
- `craft` (optional): How to craft the item

### Sets
_Only for sets_

- `level`: Set level
- `set_bonuses`: List of string set bonuses
- `set_total_bonuses` (optional): List of string set total bonuses

### Pets
_Only for pets_

- `level`: Pet level
- `description`: Pet description
- `conditions` (optional): List of string conditions
- `evolutionary_effects` (optional): List of string evolutionary effects

### Mounts
_Only for mounts_

- `effects` (optional): List of string effects
- `characteristics`: List of string characteristics

### Consumables
_Only for consumables_

- `level`: Consumable level
- `description`: Consumable description
- `effects` (optional): List of string effects
- `conditions` (optional):List of string conditions
- `craft` (optional): How to craft the item

### Resources
_Only for resources_

- `level`: Resource level
- `description`: Resource description
- `effects` (optional): List of string effects
- `conditions` (optional): List of string conditions
- `craft` (optional): How to craft the item

### Ceremonial items
_Only for ceremonial items_

- `level`: Ceremonial item level
- `description`: Ceremonial item description
- `effects` (optional): List of string effects
- `conditions` (optional): List of string conditions
- `characteristics` (optional): List of string characteristics
- `craft` (optional): How to craft the item

### Sidekicks
_Only for sidekicks_

- `description`: Sidekick description
- `characteristics`: List of string characteristics

### Idols
_Only for idols_

- `level`: Idol level
- `description`: Idol description
- `bonuses`: List of string bonuses
- `spells`: List of string spells
- `craft`: How to craft the item

### Harness
_Only for harnesses_

- `level` : Harness level
- `description` : Harness description
- `conditions` (optional): List of string conditions
- `craft` (optional): How to craft the item


