## TEST USERS
| id | email | password | nickname |
|:-:|:-:|:-:|:-:|
| 39 | tu1@mail.com | password123 | tu1
| 40 | tu2@mail.com | password123 | tu2
| 41 | tu3@mail.com | password123 | tu3
| 42 | tu4@mail.com | password123 | tu4
## REST API
#  users
### create user
```
curl -X POST -H 'Content-Type: application/json' --data '{"email": "user@mail.com", "password": "password123", "nickname": "dude"}'  'http://pvpc:pefalpe987@localhost:3000/users'
```
### authenticate user
```
curl -X POST -H 'Content-Type: application/json' --data '{"email": "user@mail.com", "password": "password123"}'  'http://pvpc:pefalpe987@localhost:3000/users/login'
```
### edit user
```
curl -X PATCH -H 'Content-Type: application/json' --data '{"nickname": "duuuude"}'  'http://pvpc:pefalpe987@localhost:3000/users/38?access_token=yesD_1fCXwKY_x-zNay6'
```
### show single user
```
curl -X GET -H 'Content-Type: application/json'  'http://pvpc:pefalpe987@localhost:3000/users/38
```
### show multiple users
```
curl -X GET -H 'Content-Type: application/json' 'http://pvpc:pefalpe987@localhost:3000/users?offset=10&limit=3'
```
### search user by nickname
```
curl -X GET -H 'Content-Type: application/json' 'http://pvpc:pefalpe987@localhost:3000/users?nickname=user2'
```
### search strangers to user
```
curl -X GET -H 'Content-Type: application/json' 'http://pvpc:pefalpe987@localhost:3000/users?strangers_to_user_id=38'
```
# games
### show multiple games
```
curl -X GET -H 'Content-Type: application/json' 'http://pvpc:pefalpe987@localhost:3000/games?offset=3&limit=5'
```
### show single game
```
curl -X GET -H 'Content-Type: application/json' 'http://pvpc:pefalpe987@localhost:3000/games/1'
```
# game ownerships
### add game to user's games
```
curl -X POST -H 'Content-Type: application/json' --data '{"user_id": 38, "nickname": "plajer", "game_id": 1}'  'http://pvpc:pefalpe987@localhost:3000/game_ownerships?access_token=yesD_1fCXwKY_x-zNay6'
```
### update user's nickname in game
```
curl -X PATCH -H 'Content-Type: application/json' --data '{"nickname": "pro_platyer"}'  'http://pvpc:pefalpe987@localhost:3000/game_ownerships/125?access_token=yesD_1fCXwKY_x-zNay6'
```
### show user's games
```
curl -X GET -H 'Content-Type: application/json' 'http://pvpc:pefalpe987@localhost:3000/game_ownerships?access_token=yesD_1fCXwKY_x-zNay6&user_id=38'
```
### remove game from user's games
```
curl -X DELETE -H 'Content-st:3000/game_ownerships/124?access_token=yesD_1fCXwKY_x-zNay6'
```
# friendship invites
### invite user to be friend
```
curl -X POST -H 'Content-Type: application/json' --data '{"from_user_id": 38, "to_user_id": 2}'  'http://pvpc:pefalpe987@localhost:3000/friendship_invites?access_token=3N2R2RcW_QKjKvpmAYcS'
```
### show user's friendship invites
```
curl -X GET -H 'Content-Type: application/json' 'http://pvpc:pefalpe987@localhost:3000/friendship_invites?to_user_id=38&access_token=3N2R2RcW_QKjKvpmAYcS'
```
