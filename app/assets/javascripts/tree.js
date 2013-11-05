$(document).ready(function() {
  var id = $("#page-id").data("id");
  $.get("/items/" + id + ".json", function(data) {
    directoryEntry = data["directory_entry"];
    html =  "<ol class='tree'>";
    html += buildRoot(directoryEntry);
    html += "</ol>";
    $("#file-tree pre").html(html);
  });
});

function buildRoot(root) {
  html = "<ol class='tree'>";
  for (var i = 0; i < root.children.length; i++) {
    var child = root.children[i];
    if (child.type == "directory")
      html += buildDirectory(child, "");
    else if (child.type == "file")
      html += buildFile(child, "");
  }
  html += "</ol>";
  return html;
}

function buildDirectory(dir, base) {
  html = "<li class='tree'>";
  html += "<label for='" + base + "/" + dir.name + "'>" + dir.name + "</label>";
  html += "<input type='checkbox' id='" + base + "/" + dir.name + "' />";
  html += "<ol>";
  for (var i = 0; i < dir.children.length; i++) {
    var child = dir.children[i];
    if (child.type == "directory")
      html += buildDirectory(child, base + "/" + dir.name);
    else if (child.type == "file")
      html += buildFile(child, base + "/" + dir.name);
  }
  html += "</ol></li>";
  return html;
}

function buildFile(file, base) {
  return "<li id='" + file.content_url + "' class='tree file'><a onclick='return fileClicked(this)' href='#'>" + file.name + "</a></li>";

}

function fileClicked(link) {
  contentUrl = $(link).parent().attr('id');
  console.log(contentUrl);
  $.get(contentUrl, function(data) {
    file_entry_content = data['file_entry_content'];
    content = file_entry_content['content'];
    console.log(content);
    text = $("#file-content pre");
    text.text(content);
    text.attr('class', 'prettyprint');
    prettyPrint();
  });
  return false;
}
