# configuration
source_dir = ""
drafts_dir = "_drafts"
new_post_ext = "markdown"

# usage : rake draft:create
desc "Begin a new draft post in #{source_dir}#{drafts_dir}"
  namespace :draft do
    task :create, :title do |t, args|
    if args.title
      title = args.title
    else
      title = get_stdin("Enter a title for your post (draft) : ")
    end
    filename = "#{source_dir}#{drafts_dir}/#{title.to_url}.#{new_post_ext}"
    if File.exist?(filename)
      abort("rake aborted!") if ask("#{filename} already exists. Do you want to overwrite?", ['y', 'n']) == 'n'
    end
    puts "Creating new post: #{filename}"
    File.open(filename, 'w') do |post|
      post.puts "---"
      post.puts "layout: post"
      post.puts "title: \"#{title.gsub(/&/,'&amp;')}\""
      post.puts "date: #{Time.now.strftime('%Y-%m-%d %H:%M:%S %z')}"
      post.puts "categories: "
      post.puts "---"
    end
  end
end