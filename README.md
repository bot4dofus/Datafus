<img src="https://github.com/LucBerge/Datafus/raw/master/images/banner_tags.png" />

# Datafus

Datafus is a small python3 tool to build the dofus database by scrapping the website. The final database is a JSON file.

- [French database](https://github.com/LucBerge/Datafus/blob/master/data/dofus.fr.json)
- [English database](https://github.com/LucBerge/Datafus/blob/master/data/dofus.en.json)
- [German database](https://github.com/LucBerge/Datafus/blob/master/data/dofus.de.json)
- [Spanish database](https://github.com/LucBerge/Datafus/blob/master/data/dofus.es.json)
- [Itanian database](https://github.com/LucBerge/Datafus/blob/master/data/dofus.it.json)
- [Portuguese database](https://github.com/LucBerge/Datafus/blob/master/data/dofus.pt.json)

## JSON structure

- `monsters`  **_List_**: List of monsters in the game
- `weapons` **_List_**: List of weapons in the game
- `equipments` **_List_**: List of equipments in the game
- `sets` **_List_**: List of sets in the game
- `pets` **_List_**: List of pets in the game
- `mounts` **_List_**: List of mounts in the game
- `consumables` **_List_**: List of consumables in the game
- `resources` **_List_**: List of resources in the game
- `ceremonial_items` **_List_**: List of ceremonial items in the game
- `sidekicks` **_List_**: List of sidekicks items in the game
- `idols` **_List_**: List of idols in the game
- `harnesses` **_List_**: List of harnesses in the game

## Item structure

The following table show the feilds which exists or not for a given item.

✔️ The field is mandatory

⚫ The field is optionnal

❌ The field doesn't exists


|Field                 | Monster | Weapon | Equipment | Set | Pet | Mount | Consumable | Resource | Cremonial item | Sidekick | Idol | Harnesse |
|----------------------|:-------:|:------:|:---------:|:---:|:---:|:-----:|:----------:|:--------:|:--------------:|:--------:|:----:|:--------:|
|`url` **key**         |✔️       |✔️       |✔️          |✔️   |✔️    |✔️      |✔️          |✔️         |✔️               |✔️        |✔️     |✔️         |
|`id`                  |✔️       |✔️       |✔️          |✔️   |✔️    |✔️      |✔️          |✔️         |✔️               |✔️        |✔️     |✔️         |
|`name`                |✔️       |✔️       |✔️          |✔️   |✔️    |✔️      |✔️          |✔️         |✔️               |✔️        |✔️     |✔️         |
|`img`                 |✔️       |✔️       |✔️          |✔️   |✔️    |✔️      |✔️          |✔️         |✔️               |✔️        |✔️     |✔️         |
|`type`                |✔️       |✔️       |✔️          |✔️   |✔️    |✔️      |✔️          |✔️         |✔️               |✔️        |✔️     |✔️         |
|`level`               |✔️       |✔️       |✔️          |✔️   |✔️    |❌     |✔️           |✔️         |✔️               |❌       |✔️     |✔️         |
|`description`         |❌       |✔️       |✔️          |❌   |✔️    |❌     |✔️          |✔️         |✔️               |✔️        |✔️     |✔️         |
|`effects`             |❌       |⚫       |⚫          |❌   |❌    |⚫     |⚫         |⚫         |⚫               |❌        |❌     |❌        |
|`conditions`          |❌       |⚫       |⚫          |❌   |❌    |❌     |⚫         |⚫         |⚫               |❌        |❌     |⚫        |
|`characteristics`     |✔️       |✔️       |❌          |❌   |❌    |✔️     |❌          |❌        |⚫               |✔️        |❌     |❌        |
|`resistances`         |✔️       |❌       |❌          |❌   |❌    |❌     |❌         |❌         |❌              |❌        |❌     |❌        |
|`craft`               |❌       |⚫       |⚫          |❌   |❌    |❌     |⚫         |⚫         |⚫               |❌        |✔️     |⚫        |
|`bonuses`             |❌       |❌       |❌          |❌   |❌    |❌     |❌         |❌         |❌              |❌        |✔️     |❌        |
|`items`               |❌       |❌       |❌          |✔️   |❌    |❌     |❌         |❌         |❌              |❌        |❌     |❌        |
|`set_bonuses`         |❌       |❌       |❌          |✔️   |❌    |❌     |❌         |❌         |❌              |❌        |❌     |❌        |
|`set_total_bonuses`   |❌       |❌       |❌          |⚫   |❌    |❌     |❌         |❌         |❌              |❌        |❌     |❌        |
|`evolutionary_effects`|❌       |❌       |❌          |❌   |⚫    |❌     |❌         |❌         |❌              |❌        |❌     |❌        |
|`spells`              |❌       |❌       |❌          |❌   |❌    |❌     |❌        |❌          |❌              |❌        |✔️     |❌        |

## Fields description

- `url` **_String_**: Url of the item. **Unique for each item.**
```json
"url":...
```

- `id` **_Integer_**: Id of the item.
```json
"id":...
```

- `name` **_String_**: Name of the item.
```json
"name":...
```

- `img` **_String_**: Image url of the item.
```json
"img":...
```

- `type` **_String_**: Type of the item (Bow, Cereal, Ore, Beer...)
```json
"type":...
```

- `level` **_Integer_ (Monsters exclude)**: Level of the item from 1 to 200.
```json
"level":...
```

- `level` **_Tuple of Integer_ (Monsters only)**: Minimal and Maximal value of the monster from 1 to 200.
```json
"level":[
  ...,
  ...
]
```

- `description`  **_String_**: Description of the item.
```json
"description":...
```

- `effects` **_List of String_** : List of string effects.
```json
"effects":[
  ...,
  ...
]
```

- `conditions` **_List of String_** : List of string conditions.
```json
"conditions":[
  ...,
  ...
]
```

- `characteristics` **_List of String_**: List of string characteristics.
```json
"characteristics":[
  ...,
  ...
]
```

- `resistances` **_List of String_**: List of string resistances.
```json
"resistances":[
  ...,
  ...
]
```

- `craft` **_List of Craft_** : How to craft the item.
```json
"craft":[
  {
    "url":...,
    "quantity":...
  },
  {
    "url":...,
    "quantity":...
  },
  ...
]
```

- `bonuses` **_List of String_**: List of string bonuses.
```json
"bonuses":[
  ...,
  ...
]
```

- `items` **_List of String_**: List of items url.
```json
"items":[
  ...,
  ...
]
```

- `set_bonuses` **_List of String_**: List of string set bonuses.
```json
"set_bonuses":[
  ...,
  ...
]
```

- `set_total_bonuses` **_List of String_** : List of string set total bonuses.
```json
"set_total_bonuses":[
  ...,
  ...
]
```

- `evolutionary_effects` **_List of String_** : List of string evolutionary effects.
```json
"evolutionary_effects":[
  ...,
  ...
]
```

- `spells` **_List of String_**: List of string spells.
```json
"spells":[
  ...,
  ...
]
```
