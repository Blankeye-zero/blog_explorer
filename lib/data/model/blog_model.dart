class BlogModel{
  String id;
  String title;
  String imageUrl;

  BlogModel.fromJson(Map blog) :
    id= blog['id'],
    title = blog['title'],
    imageUrl = blog['image_url'];
}