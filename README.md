## REST API
#  users
### create user
```
curl -X POST -H 'Content-Type: application/json' --data '{"model": {"email": "user@mail.com", "password": "password123", "nickname": "dude"}}'  'http://pvpc:pefalpe987@localhost:3000/public/users'
```
### authenticate user
```
curl -X POST -H 'Content-Type: application/json' --data '{"email": "user@mail.com", "password": "password123"}'  'http://pvpc:pefalpe987@localhost:3000/public/users/login'
```
### edit user
```
curl -X PATCH -H 'Content-Type: application/json' --data '{"model": {"nickname": "duuuude"}}'  'http://pvpc:pefalpe987@localhost:3000/public/users/38?access_token=yesD_1fCXwKY_x-zNay6'
```
### show single user
```
curl -X GET -H 'Content-Type: application/json'  'http://pvpc:pefalpe987@localhost:3000/public/users/38
```
### show multiple users
```
curl -X GET -H 'Content-Type: application/json' 'http://pvpc:pefalpe987@localhost:3000/public/users?offset=10&limit=3'
```
### search user by nickname
```
curl -X GET -H 'Content-Type: application/json' 'http://pvpc:pefalpe987@localhost:3000/public/users?nickname=user2'
```
### search strangers to user
```
curl -X GET -H 'Content-Type: application/json' 'http://pvpc:pefalpe987@localhost:3000/public/users?strangers_to_user_id=38'
```
# games
### show multiple games
```
curl -X GET -H 'Content-Type: application/json' 'http://pvpc:pefalpe987@localhost:3000/public/games?offset=3&limit=5'
```
### show single game
```
curl -X GET -H 'Content-Type: application/json' 'http://pvpc:pefalpe987@localhost:3000/public/games/1'
```
# game ownerships
### add game to user's games
```
curl -X POST -H 'Content-Type: application/json' --data '{"model": {"user_id": 38, "nickname": "plajer", "game_id": 1}}'  'http://pvpc:pefalpe987@localhost:3000/public/game_ownerships?access_token=yesD_1fCXwKY_x-zNay6'
```
### update user's nickname in game
```
curl -X PATCH -H 'Content-Type: application/json' --data '{"model": {"nickname": "pro_platyer"}}'  'http://pvpc:pefalpe987@localhost:3000/public/game_ownerships/125?access_token=yesD_1fCXwKY_x-zNay6'
```
### show user's games
```
curl -X GET -H 'Content-Type: application/json' 'http://pvpc:pefalpe987@localhost:3000/public/game_ownerships?access_token=yesD_1fCXwKY_x-zNay6&user_id=38'
```
### remove game from user's games
```
curl -X DELETE -H 'Content-st:3000/game_ownerships/124?access_token=yesD_1fCXwKY_x-zNay6'
```
# friendship invites
### invite user to be friend
```
curl -X POST -H 'Content-Type: application/json' --data '{"model": {"from_user_id": 38, "to_user_id": 2}}'  'http://pvpc:pefalpe987@localhost:3000/public/friendship_invites?access_token=3N2R2RcW_QKjKvpmAYcS'
```
### show user's friendship invites
```
curl -X GET -H 'Content-Type: application/json' 'http://pvpc:pefalpe987@localhost:3000/public/friendship_invites?to_user_id=38&access_token=3N2R2RcW_QKjKvpmAYcS'
```
