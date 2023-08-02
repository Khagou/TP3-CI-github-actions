# CI Github action pour une app Python

## Description des fichiers contenu dans le repo

## Contexte et composition du repot

Il est demande de mettre une chaine d'integration contine pour une application Python. Aucun outils d'orchestration n'etant impose, mon choix a ete Github action celui-ci etant simple d'utilisation et directement integre a Github.

L'ensemble du repot permet de réaliser des tests et analyses sur l'application ainsi que les rapports pour: - la verification des normes de codage - la verification des copier-coller - l'analyse de la complexite cyclommatique - les test unitaires

Le repot est composé de 2 dossier et 4 scripts shell:

- Le dossier **.github** est lui meme compose de :
  - d'un dossier **workflows** dans le quel ce trouve le workflow github action
- Le dossier **app** qui represente l'ensemble de l'application Python et est decoupé en sous dossier dont un dossier **test** lui meme compose de:
  - un dossier **system** dans lequel on retrouve les test avec robotframework
  - un dossier **unit** dans lequel on retrouve les test avec unittest
- Le dossier **docker-app** contient un dossier **python** qui contient le dockerfile pour notre image docker pour l'application

## Prerequis

Disposer d'un compte Github et d'un compte sur le hub docker.

## Presentation du workflow

Si on regarde le workflow on constate que le workflow:

1. Lance le test avec pylint
2. Lance les tests unittest
3. Lance les tests avec robotframework
4. Il lance ensuuite le test radon raw
5. Pour finir avec les tests il lance le test radon cc
6. Une fois les tests termine
