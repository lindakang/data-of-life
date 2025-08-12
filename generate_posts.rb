require 'json'
require 'date'

# 設定文章檔案所在的資料夾
posts_dir = 'posts'
# 設定要輸出的 JSON 檔案路徑
json_output_path = '_data/posts.json'

# 初始化一個用來存放所有文章資料的 Hash
all_posts_data = {
  "research" => [],
  "industry-news" => [],
  "biotech-companies" => [],
  "career" => [],
  "life-chat" => []
}

# 遍歷 posts 資料夾中的所有 .html 檔案
Dir.glob(File.join(posts_dir, '*.html')).each do |filepath|
  # 從檔案名稱中提取資訊，例如 2025-03-27-korean-microsushi.html
  filename = File.basename(filepath, '.html')
  parts = filename.split('-')
  
  # 簡單的假設：從檔案名稱解析日期和ID
  date = "#{parts[0]}-#{parts[1]}-#{parts[2]}"
  id = filename

  # *** 重要：如何獲取標題、摘要、分類和標籤？ ***
  # 由於您的文章內容只是 HTML 片段，我們需要一個地方儲存這些 "元數據" (metadata)
  # 最佳實踐是在每個文章檔案的開頭，使用像 Jekyll 一樣的 YAML Front Matter
  
  # 這裡我們先用一些假資料當作範例
  # 您需要根據您的文章內容來調整這部分
  title = "文章標題 - #{filename}"
  summary = "這是 #{filename} 的摘要..."
  category = "research" # 假設所有文章都在 research 分類
  tags = ["標籤1", "標籤2"]
  read_time = "5 min read"

  # 組合成一篇文章的資料
  post_data = {
    "id" => id,
    "title" => title,
    "date" => date,
    "category" => category,
    "tags" => tags,
    "summary" => summary,
    "readTime" => read_time,
    "filename" => "#{filename}.html"
  }
  
  # 將文章資料加到對應的分類中
  if all_posts_data.key?(category)
    all_posts_data[category] << post_data
  end
end

# 將 Hash 轉換成格式化的 JSON 字串
json_content = JSON.pretty_generate(all_posts_data)

# 將 JSON 內容寫入檔案
File.write(json_output_path, json_content)

puts "成功！_data/posts.json 已經根據 posts 資料夾的內容重新產生。"
