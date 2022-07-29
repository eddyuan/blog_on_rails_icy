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

## Add `bcrypt`, `cancancan` in `Gemfile`

```rb
...
gem "bcrypt", "~> 3.1.7"
gem "cancancan"
```

## Generate User Model

```
rails g model User name:string email:string:uniq password_digest:string
```

```rb
# user.rb
class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  has_secure_password
  # :nullify means clear the reference
  # but still keep comments/posts when destroy the user
  # it should work with optional:true in the reference
  has_many :comments, dependent: :nullify
  has_many :posts, dependent: :nullify
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, format: VALID_EMAIL_REGEX
  # validate password when it's passed to the param
  validates :password,
            confirmation: true,
            length: {
              within: 6..40
            },
            if: -> { password.present? }
  # only when present so it won't trigger when updating user profile
end
```

## Add `is_admin` column for Users

```
rails g migration AddIsAdminToUsers is_admin:boolean
```

```rb
# add_is_admin_to_users.rb
class AddIsAdminToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :is_admin, :boolean, default: false #<= Add this default:false
  end
end
```

## Add `User` to `Posts` DB

```
rails g migration AddUserToPosts user:references
```

#### Make nullable so `Posts` don't get destroyed when destroy user

remove `null: false` in `AddUserToPosts` migration
add `belongs_to :user, optional: true` in `posts.rb`

## Add `User` to `Comments` DB

```
rails g migration AddUserToComments user:references
```

#### Make nullable so `Comments` don't get destroyed when destroy user

remove `null: false` in `AddUserToComments` migration
add `belongs_to :user, optional: true` in `comments.rb`

## Create `UsersController`

```
rails g controller users
```

- Edit `users_controllers` accordingly
- Create necessary views for users

## Create `SessionsController`

```
rails g controller sessions
```

- Edit `sessions_controller` accordingly
- Create login view views for session

## Implent `Users` & `Sessions` in route and page

- Add users/sessions routing in `routes.rb`
- Add the buttons in navbar in `application.html.erb` accordingly

## Add CanCan:Ability Model & edit `ability.rb`

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

## Implents Global auth helpers & functions

```rb
# application_controller.rb
# define functions & helpers for user auth
def current_user
  @current_user ||= User.find_by_id session[:user_id]
end

helper_method :current_user

def user_signed_in?
  current_user.present?
end

helper_method :user_signed_in?

def authenticated_user!
  unless user_signed_in?
    flash[:danger] = "Please sign in"
    redirect_to signup_path
  end
end
```

## Implents Action-Specific auth requirements & add User in `Posts` and `Comments`

```rb
# posts_controller.rb
# define which actions need authenticated_user

...

before_action :authenticated_user!, except: %i[index show]
before_action :authorized_user!, only: %i[edit update destroy]

...

def create
    @post = Post.new(post_params)
    @post.user = @current_user

...

def authorized_user!
  unless can?(:crud, @post)
    flash[:danger] = "You don't have permission"
    redirect_to root_path
  end
end

```

```rb
# comments_controller.rb
# define which actions need authenticated_user

...

before_action :authenticated_user!, except: %i[index show]
before_action :authorized_user!, only: [:destroy]

...

def create
    @comment = Comment.new(params.require(:comment).permit(:body))
    @comment.user = @current_user

...

def authorized_user!
  unless can?(:destroy, @comment)
    flash[:danger] = "You don't have permission"
    redirect_to post_path(@post)
  end
end
```

## Adjust the views respectively with `can?` & `user_signed_in?` rules

- `application.html.erb`
- `posts/show.html.erb`
- etc...

## We can also add `Users` for admin to let admin see all the users

- `users/index.html.erb`
- also add in `routes.rb`

## Add seeds in `seeds.rb`

## And finally we are done ...
