# TP3 - CI Github action pour une app Python

## Contexte et composition du repot

Il est demande de mettre en place une chaine d'integration contine pour une application Python. Aucun outils d'orchestration n'etant impose j'ai donc choisi Github action, celui-ci etant simple d'utilisation et directement integre a Github.

L'ensemble du repot permet de réaliser des tests et analyses sur l'application ainsi que les rapports pour:

- la verification des normes de codage
- la verification des copier-coller
- l'analyse de la complexite cyclommatique
- les test unitaires

Le repot est composé de 2 dossier et 4 scripts shell:

- Le dossier **.github** est lui meme compose de :
  - d'un dossier **workflows** dans le quel ce trouve le workflow github action
- Le dossier **app** qui represente l'ensemble de l'application Python et est decoupé en sous dossier dont un dossier **test** lui meme compose de:
  - un dossier **system** dans lequel on retrouve les test avec robotframework
  - un dossier **unit** dans lequel on retrouve les test avec unittest
- Le dossier **docker-app** contient un dossier **python** qui contient le dockerfile pour notre image docker pour l'application

## Prerequis

Disposer de git sur votre machine, d'un compte Github et d'un compte sur le hub docker.

## Presentation du workflow

Si on regarde le workflow on constate que le workflow:

1. Lance le test avec pylint
2. Lance les tests unittest
3. Lance les tests avec robotframework
4. Il lance ensuite le test radon raw
5. Pour finir avec les tests il lance le test radon cc
6. Une fois les tests termine et valide lancement du build et du push de l'image docker sur le hub docker.

## Configuration des parametres de pipeline

1- Cloner l'ensemble du repot sur votre machine

```
git clone https://github.com/Khagou/TP3-CI-github-actions.git
```

2- Creer un repot github et suivre les commandes ci dessous (pour l'url du repot github acceder au repot cliquer sur "<> Code" et copier l'url dans l'onglet "HTTPS") !

```
git init
git branch -M main
git remote add origin < url de votre repot github >
```

3- Creer un repot sur le hubdocker

4- Toujours sur le hubdocker cliquer sur le pseudo en haut a droite puis _"Account settings"_ dans le bandeau de gauche _"Security"_ puis _"New acces token"_, finallement copier le token qui servira a la prochaine etape

5- Accèder au repot github puis au parametres de celui-ci, dans le bandeau de gauche dans la section securite cliquer sur "secrets and variables" puis Actions. Une page avec 2 onglets ("Secrets" et "Variables") s'ouvre.

1.  **Creation des Secrets**:

    . Dans l'onglet _"secrets"_ cliquer sur _New repository secret_ nommer le premier secret `DOCKER_TOKEN`, puis coller votre token cree juste avant sur le hub docker dans la section "Secret\*"
    . Recreer un nouveau secret et le nommer `DOCKER_USER`, entrer son pseudo hub docker en secret

2.  **Creation des Variables**:
    1. Acceder a l'onglet _"variable"_ puis cliquer sur _New repository variable_, nommer cette premiere variable `DOCKER_REPO` et entrer en valeur le nom du repot creer sur le hub docker lors de l'etape 3
    2. Creer une 2eme variable `IMAGE_FILE` laquelle contiendra le chemin du dockerfile de l'app si vous n'avez rien modifier entrez en valeur `docker-app/python/Dockerfile` si non entrez le nouveau chemin
    3. Creer une 3eme variable `IMAGE_OS` et entrez la valeur `ubuntu-latest` ou celle de votre choix, a savoir que le workflow est parametre pour du Debian, certaines modifications peuvent etre necessaire pour un autre OS.
    4. Creer ensuite une 4eme variable `ROBOT_FILE_NAME` et enregistrez y en valeur le nom du fichier robotframework, si vous ne l'avez pas modifie `machine.robot`
    5. Puis creer une 5eme variable `ROBOT_FILE_WAY` qui contiendra le chemin du fichier robotframework, si non modifie `./app/test/system`
    6. Creer une 6eme variable `DOCKER_IMAGE_VERSION` qui contiendra la version de l'image de votre application
    7. Pour finir la 7eme variable s'appellera `UNITTEST_FILE` et contiendra le chemin du fichier unittest, si non modifie `test/unit/test.py`

6- Sur la machine, dans un terminal ce placer dans le dossier qui contient l'ensemble du repot, creer une nouvelle branche et ce placer dedans. Vous pouvez par exemple appeler la branche cicd.

```
git checkout -b < nom de la branche >
```

7- Realiser un commit de notre app

```
git commit -am "< entrer un commentaire de votre choix >"
```

8- Push de l'ensemble sur notre repot github

```
git push origin < nom de la branche cree a l'etape 6>
```

9- Acceder au repot sur github, dans le bandeau du haut cliquer sur _"Pull requests"_ dans la nouvelle page cliquer sur _"New pull request"_ vous devriez alors voir afficher votre cicd selectionnez la github vous affiche alors les modification apporte, cliquer sur _"Create pull request"_, dans la page qui s'est ouverte vous pouvez entrer un commentaire qui est facultatif, cliquer a nouveau sur _"Create pull request"_ afin de creer la pull request a partir de votre branche cicd.

10- Le workflow ce lance et va proceder a l'enmsemble des tests et si tout ce deroule bien il lancera le build et le push de l'image docker. Pour voir votre workflow tourner vous pouvez cliquer le sur bouton _"Actions"_ sur le bandeau du haut.

11- Une fois que le workflow a fini de tourner et si tout c'est bien deroule vous vous pouvez retourner sur votre pull request, github devrait vous signaler que tout les test sont passe, il ne reste plus qu'a merge la pull request en cliquant sur le bouton _"Merge pull request"_, vous pouvez alors modifier le commentaire puis cliquer sur _"Confirm merge"_.
