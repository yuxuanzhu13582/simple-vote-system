module ApplicationHelper

  def user_gender(gneder)
    if gneder == 1
        "男"
    elsif gneder == 0
        "女"
    else
        "不想說"
    end
  end

  def icon_link_to(label, path, icon)
    link_to path do
      content_tag :span, class: "glyphicon glyphicon-#{icon}" do
        label
      end
    end
  end

end
