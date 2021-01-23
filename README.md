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

The following table show the feilds which exists or not for a given item.

✔️ The field is mandatory

✴️ The field is optionnal

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
|`effects`             |❌       |✴️       |✴️          |❌   |❌    |✴️     |✴️         |✴️         |✴️               |❌        |❌     |❌        |
|`conditions`          |❌       |✴️       |✴️          |❌   |❌    |❌     |✴️         |✴️         |✴️               |❌        |❌     |✴️        |
|`characteristics`     |✔️       |✔️       |❌          |❌   |❌    |✔️     |❌          |❌        |✴️               |✔️        |❌     |❌        |
|`resistances`         |✔️       |❌       |❌          |❌   |❌    |❌     |❌         |❌         |❌              |❌        |❌     |❌        |
|`craft`               |❌       |✴️       |✴️          |❌   |❌    |❌     |✴️         |✴️         |✴️               |❌        |✔️     |✴️        |
|`bonuses`             |❌       |❌       |❌          |❌   |❌    |❌     |❌         |❌         |❌              |❌        |✔️     |❌        |
|`items`               |❌       |❌       |❌          |✔️   |❌    |❌     |❌         |❌         |❌              |❌        |❌     |❌        |
|`set_bonuses`         |❌       |❌       |❌          |✔️   |❌    |❌     |❌         |❌         |❌              |❌        |❌     |❌        |
|`set_total_bonuses`   |❌       |❌       |❌          |✴️   |❌    |❌     |❌         |❌         |❌              |❌        |❌     |❌        |
|`evolutionary_effects`|❌       |❌       |❌          |❌   |✴️    |❌     |❌         |❌         |❌              |❌        |❌     |❌        |
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

- `level` **_Integer_**: Level of the item from 1 to 200.
```json
"level":...
```

- `description`  **_String_**: Description of the item.
```json
"description":...
```

- `effects` **_List_** : List of string effects.
```json
"effects":[
  ...,
  ...
]
```

- `conditions` **_List_** : List of string conditions.
```json
"conditions":[
  ...,
  ...
]
```

- `characteristics` **_List_**: List of string characteristics.
```json
"characteristics":[
  ...,
  ...
]
```

- `resistances` **_List_**: List of string resistances.
```json
"resistances":[
  ...,
  ...
]
```

- `craft` **_List_** : How to craft the item.
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

- `bonuses` **_List_**: List of string bonuses.
```json
"bonuses":[
  ...,
  ...
]
```

- `items` **_List_**: List of items url.
```json
"items":[
  ...,
  ...
]
```

- `set_bonuses` **_List_**: List of string set bonuses.
```json
"set_bonuses":[
  ...,
  ...
]
```

- `set_total_bonuses` **_List_** : List of string set total bonuses.
```json
"set_total_bonuses":[
  ...,
  ...
]
```

- `evolutionary_effects` **_List_** : List of string evolutionary effects.
```json
"evolutionary_effects":[
  ...,
  ...
]
```

- `spells` **_List_**: List of string spells.
```json
"spells":[
  ...,
  ...
]
```
