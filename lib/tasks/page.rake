# configuration
source_dir = ""
pages_dir = "pages"
new_post_ext = "markdown"

# usage : rake post:create
desc "Begin a new page in #{source_dir}#{pages_dir}"
  namespace :page do
    task :create, :title do |t, args|
    if args.title
      title = args.title
    else
      title = get_stdin("Enter a title for your page : ")
    end
    filename = "#{source_dir}#{pages_dir}/#{Time.now.strftime('%Y-%m-%d')}-#{title.to_url}.#{new_post_ext}"
    if File.exist?(filename)
      abort("rake aborted!") if ask("#{filename} already exists. Do you want to overwrite?", ['y', 'n']) == 'n'
    end
    puts "Creating new page: #{filename}"
    File.open(filename, 'w') do |post|
      post.puts "---"
      post.puts "layout: page"
      post.puts "title: #{title.gsub(/&/,'&amp;')}"
      post.puts "permalink: /#{title.to_url.gsub(/&/,'&amp;')}/"
      post.puts "---"
    end
  end
end