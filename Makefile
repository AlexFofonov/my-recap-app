# fmt: Форматтер
fmt:
	mint run swiftformat MyRecap --swiftversion 5.8.1 --header "\n {file} \n\n AlexFofonov in {created.year} \n"

## swiftgen: Генерация ресурсов
gen:
	mint run https://github.com/SwiftGen/SwiftGen
