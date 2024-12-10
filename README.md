> [!CAUTION]
> **THIS REPO IS DEPRECATED**
>
> Dofus 3 has been released on the 3rd of December 2024. This new version uses Unity Engine with a completly different file structure. Here are some projects equivalent to Datafus for Dofus 3:
> - [dofusdude/doduda](https://github.com/dofusdude/doduda)
> - [Dofus-Batteries-Included/DDC](https://github.com/Dofus-Batteries-Included/DDC)
> 

<p align="center">
  <img width="100%" src="https://github.com/LucBerge/Datafus/raw/master/images/banner_tags.svg" />
</p>

[![Workflow](https://img.shields.io/github/actions/workflow/status/LucBerge/Datafus/workflow.yml?branch=master)](https://github.com/bot4dofus/Datafus/actions/workflows/workflow.yml)
[![Release](https://img.shields.io/github/v/release/LucBerge/Datafus)](https://github.com/LucBerge/Datafus/releases)
[![License](https://img.shields.io/github/license/LucBerge/Datafus)](https://github.com/LucBerge/Datafus/blob/master/LICENSE)
  
# Datafus

Datafus builds the dofus database by extracting the Dofus files. The objectives are multiple:
- Extract the Dofus source code and make it public
- Build a JSON database representing all the socket events
- Extract D2O files and build a JSON database containing all the entities in the game
- Extract D2I files and build a JSON database for string translation
- Build Java classes for socket events
- Build Java classes for entities
- Compare differencies between versions

## Download the data

If you need the data in local for your project, you can download it in the [release section](https://github.com/LucBerge/Datafus/releases/latest).

## Workflow

<p align="center">
  <img width="80%" src="https://github.com/LucBerge/Datafus/raw/master/images/flows.svg" />
</p>
