<img src="https://github.com/LucBerge/Datafus/raw/master/images/banner_tags.png" />

# Datafus

Datafus is a small python3 tool to build the dofus database by scrapping the website. The final database is a JSON file.

- [French database](https://github.com/LucBerge/Datafus/blob/master/data/dofus.fr.json)
- [English database](https://github.com/LucBerge/Datafus/blob/master/data/dofus.en.json)
- [German database](https://github.com/LucBerge/Datafus/blob/master/data/dofus.de.json)
- [Spanish database](https://github.com/LucBerge/Datafus/blob/master/data/dofus.es.json)
- [Itanian database](https://github.com/LucBerge/Datafus/blob/master/data/dofus.it.json)
- [Portuguese database](https://github.com/LucBerge/Datafus/blob/master/data/dofus.pt.json)

# JSON structure

- `monsters`  **_List_**: List of monsters in the game (1832)
- `weapons` **_List_**: List of weapons in the game (726)
- `equipments` **_List_**: List of equipments in the game (2329)
- `sets` **_List_**: List of sets in the game (331)
- `pets` **_List_**: List of pets in the game (131)
- `mounts` **_List_**: List of mounts in the game (142)
- `consumables` **_List_**: List of consumables in the game (1415)
- `resources` **_List_**: List of resources in the game (2780)
- `ceremonial_items` **_List_**: List of ceremonial items in the game (711)
- `sidekicks` **_List_**: List of sidekicks items in the game (12)
- `idols` **_List_**: List of idols in the game (89)
- `harnesses` **_List_**: List of harnesses in the game (63)

## Item structure
_The following fields are always existing_

- `url` **_String_**: The item url
- `id` **_String_**: The item id
- `name` **_String_**: The item name
- `img` **_String_**: The item image url
- `type` **_String_**: The item type

### Monsters
_Only for monsters_

- `level` **_String_**: String representing the range level 
- `characteristics` **_List_**: List of string characteristics
- `resistances` **_List_**: List of string resistances

### Weapons
_Only for weapons_

- `level` **_String_**: Weapon level
- `description`  **_String_**: Weapon description
- `effects` **_List_** (optional): List of string effects
- `conditions` **_List_** (optional): List of string conditions
- `characteristics` **_List_**: List of string characteristics
- `craft` (optional): How to craft the weapon

### Equipments
_Only for equipments_

- `level` **_String_**: Equipment level
- `description`  **_String_**: Equipment description
- `effects` **_List_** (optional): List of string effects
- `conditions` **_List_** (optional): List of string conditions
- `craft` (optional): How to craft the item

### Sets
_Only for sets_

- `level` **_String_**: Set level
- `set_bonuses` **_List_**: List of string set bonuses
- `set_total_bonuses` **_List_** (optional): List of string set total bonuses

### Pets
_Only for pets_

- `level` **_String_**: Pet level
- `description` **_List_**: Pet description
- `conditions` **_List_** (optional): List of string conditions
- `evolutionary_effects` **_List_** (optional): List of string evolutionary effects

### Mounts
_Only for mounts_

- `effects` **_List_** (optional): List of string effects
- `characteristics` **_List_**: List of string characteristics

### Consumables
_Only for consumables_

- `level` **_String_**: Consumable level
- `description`  **_String_**: Consumable description
- `effects` **_List_** (optional): List of string effects
- `conditions` **_List_** (optional):List of string conditions
- `craft` (optional): How to craft the item

### Resources
_Only for resources_

- `level` **_String_**: Resource level
- `description`  **_String_**: Resource description
- `effects` **_List_** (optional): List of string effects
- `conditions` **_List_** (optional): List of string conditions
- `craft` (optional): How to craft the item

### Ceremonial items
_Only for ceremonial items_

- `level` **_String_**: Ceremonial item level
- `description`  **_String_**: Ceremonial item description
- `effects` **_List_** (optional): List of string effects
- `conditions` **_List_** (optional): List of string conditions
- `characteristics` **_List_** (optional): List of string characteristics
- `craft` (optional): How to craft the item

### Sidekicks
_Only for sidekicks_

- `description` **_String_**: Sidekick description
- `characteristics` **_List_**: List of string characteristics

### Idols
_Only for idols_

- `level` **_String_**: Idol level
- `description`  **_String_**: Idol description
- `bonuses` **_List_**: List of string bonuses
- `spells` **_List_**: List of string spells
- `craft`: How to craft the item

### Harness
_Only for harnesses_

- `level` **_String_**: Harness level
- `description`  **_String_**: Harness description
- `conditions` **_List_** (optional): List of string conditions
- `craft` (optional): How to craft the item
