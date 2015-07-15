## REST API

#  users

### create user
```
curl -X POST -H 'Content-Type: application/json' --data '{"model": {"email": "user@mail.com", "password": "password123", "nickname": "dude"}}'  'http://pvpc:pefalpe987@localhost:3000/users'
```
### authenticate user
```
curl -X POST -H 'Content-Type: application/json' --data '{"email": "user@mail.com", "password": "password123"}'  'http://pvpc:pefalpe987@localhost:3000/users/login'
```
### edit user
```
curl -X PATCH -H 'Content-Type: application/json' --data '{"model": {"nickname": "duuuude"}}'  'http://pvpc:pefalpe987@localhost:3000/users/38?access_token=yesD_1fCXwKY_x-zNay6'
```
### show user
```
curl -X GET -H 'Content-Type: application/json'  'http://pvpc:pefalpe987@localhost:3000/users/38'
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