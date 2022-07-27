## HW 6

### Generate User Model

```
rails g model User name:string email:string:uniq password_digest:string
```

### Add admin column

```
rails g migration AddIsAdminToUsers is_admin:boolean
```

Add `default:false` in `add_is_admin_to_users.rb` migration

---

### Add User to Posts

```
rails g migration AddUserToPosts user:references
```

###### Make it nullable

remove `null: false` in migration
add `belongs_to :user, optional: true` in `posts.rb`

---

### Add User to Comments

```
rails g migration AddUserToComments user:references
```

###### Make it nullable

remove `null: false` in migration
add `belongs_to :user, optional: true` in `comments.rb`
