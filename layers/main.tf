resource aws_lambda_layer_version chrome {
  layer_name = "chrome"
  filename = "${path.module}/chrome_aws_lambda.zip"
  compatible_runtimes = [
    "nodejs12.x"
  ]
}

resource aws_lambda_layer_version font_noto_cjk_regular {
  description = "Noto CJK Sans, Serif regular"
  layer_name = "font_noto_cjk_regular"
  filename = "${path.module}/font_noto_cjk_regular.zip"
  compatible_runtimes = [
    "nodejs12.x"
  ]
}

resource aws_lambda_layer_version font_color_emoji {
  layer_name = "font_color_emoji"
  description = "Color emoji"
  filename = "${path.module}/font_color_emoji.zip"
  compatible_runtimes = [
    "nodejs12.x"
  ]
}
