# ASSESSMENT 6: Rails Commenting Challenge
# Add comments to the Rails Blog Post Challenge
# Explain the purpose and functionality of the code directly below the 10 comment tags


# app/controller/blog_posts_controller.rb

# 1)The controller receive requests, fetch or save data from a model, and use a 
# view to create HTML output. A controller can thus be thought of as a middleman 
# between models and views. It makes the model BlogPost data available to the view so 
# it can display that data to the user, and it saves or updates user data to the model.
class BlogPostsController < ApplicationController
  def index
    # 2) This will list all the posts created under the Blogpost Model.
    @posts = BlogPost.all
  end

  def show
    # 3) This will show each individual post created under BlogPost Model upon its respective id # requested
    @post = BlogPost.find(params[:id])
  end

  # 4) Rails will create an instance of BlogPostController and call its new method. 
  # The empty method from the example below would work just fine because Rails will by
  # default render the new.html.erb view unless the action says otherwise.
  def new
  end

  def create
    # 5) This line creates a new instance variable called @post that holds a
    # BlogPost object built from the data, the user submitted. The blog_post_params 
    # method is used to collect all the fields from object :posts. The data was 
    # passed from the new method to create using the params object.
    @post = BlogPost.create(blog_post_params)
    if @post.valid?
      redirect_to @post
    else
      render action: :new
    end
  end

  def delete
    @post = BlogPost.find(params[:id])
    if @post.destroy
      redirect_to blog_posts_path
    else
      # 6) blog_post_path here would build a route using the @post object that
      # would look something like /posts/1 and then redirect_to would send back a 
      # 302 response to that route and the browser would follow it.
      redirect_to blog_post_path(@post)
    end
  end

  # 7) method that you can only call from inside the class where it’s defined. Private 
  # methods are a way of encapsulating functionality within a class. For example, 
  # a bartender can make a drink at a customer's request. Part of the process of making a
  # drink includes choosing liquors, mixers, garnish, and stirring everything together. As
  # a customer, you're permitted to ask the bartender for a drink (from a menu of options),
  # but you can't instruct him or her on each step. The smaller steps that make up the bartender's job 
  # can be considered private methods.
  # Private methods also signal to other developers that this method is depended on by
  # other methods in your program. It signals that they should beware of removing such 
  # a method for fear of breaking other parts of the program that they may not realize 
  # rely on it.
  private
  def blog_post_params
    # 8) Allows you to choose which attributes should be permitted for mass updating 
    # and thus prevent accidentally exposing that which shouldn't be exposed. 
    # Provides two methods for this purpose: require and permit. 
    # The former is used to mark parameters as required. The latter is used to set the
    # parameter as permitted and limit which attributes should be allowed for mass 
    # updating.
    params.require(:blog_post).permit(:title, :content)
  end

end


# app/models/blog_post.rb

# 9) This file contains the class definition for the BlogPost model.
class BlogPost < ApplicationRecord
  # 10) A has_many association indicates a one-to-many connection with another model. In this
  # case the class Blogpost contains many comments. This association indicates that each instance of the model has zero or more instances 
  # of another model. 
  has_many :comments
end
