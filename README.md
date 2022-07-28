# Basic Notes

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

# HW 6

## Generate User

```
rails g model User name:string email:string:uniq password_digest:string
```

### Add `is_admin` column for Users

```
rails g migration AddIsAdminToUsers is_admin:boolean
```

Add `default:false` in `AddIsAdminToUsers` migration

### Add CanCan:Ability Model & edit `ability.rb`

```
rails g cancan:ability
```

```rb
# ability.rb
user ||= User.new

# Define :crud
alias_action :create, :read, :edit, :update, :destroy, to: :crud

if user.is_admin?
  # manage means they can do everything (not just CRUD)
  can :manage, :all
end

# Can :crud post if use is the owner
can :crud, Post do |post|
  post.user == user
end

# Can :crud comment if use is the post or comment's owner
can :destroy, Comment do |comment|
  comment.user == user || comment.post.user == user
end

can :crud, User, id: user.id
```

### Create `UsersController`

```
rails g controller users
```

- Edit `user.rb` model accordingly
- Edit `users_controllers` accordingly
- Create necessary views for users
- Add users routing in `routes.rb`
- Add

## Add `User` to `Posts`

```
rails g migration AddUserToPosts user:references
```

#### Make nullable so `Posts` don't get destroyed when destroy user

remove `null: false` in `AddUserToPosts` migration
add `belongs_to :user, optional: true` in `posts.rb`

## Add `User` to `Comments`

```
rails g migration AddUserToComments user:references
```

#### Make nullable so `Comments` don't get destroyed when destroy user

remove `null: false` in `AddUserToComments` migration
add `belongs_to :user, optional: true` in `comments.rb`
