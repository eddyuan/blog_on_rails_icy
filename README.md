## HW 6

## Basic Notes

`%i[a b]` => `[:a, :b]` are the same

```rb
unless true
  # falsy statement
else
  # trusy statement
end
```

is same as

```rb
if true
  # trusy statement
else
  # falsy statement
end
```

## Generate User

```
rails g model User name:string email:string:uniq password_digest:string
```

### Add `is_admin` column for Users

```
rails g migration AddIsAdminToUsers is_admin:boolean
```

Add `default:false` in `AddIsAdminToUsers` migration

### Create `UsersController`

```
rails g controller users
```

### Edit `user.rb` model accordingly

### Add CanCan:Ability Model

```
rails g cancan:ability
```

## Add `User` to `Posts`

```
rails g migration AddUserToPosts user:references
```

#### Make nullable so `Posts` don't get destroyed when destroy user

remove `null: false` in `AddUserToPosts` migration
add `belongs_to :user, optional: true` in `posts.rb`

---

## Add `User` to `Comments`

```
rails g migration AddUserToComments user:references
```

#### Make nullable so `Comments` don't get destroyed when destroy user

remove `null: false` in `AddUserToComments` migration
add `belongs_to :user, optional: true` in `comments.rb`
