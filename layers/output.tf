output layers {
	value = <<TEXT
${aws_lambda_layer_version.chrome.arn}
${aws_lambda_layer_version.font_noto_cjk_regular.arn}
${aws_lambda_layer_version.font_color_emoji.arn}
TEXT
}
