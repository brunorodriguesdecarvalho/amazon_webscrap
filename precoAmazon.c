#include <stdio.h>

int main(void){
	printf("Olá, bem vindo ao Buscador de Preços na Amazon...\n");
	printf("Esse programa e a resposta ao teste solicitado...\n");
	printf("\nO teste solicitado: 'Criar um programa, zipar o codigo fonte e mandar para os emails listados abaixo. O programa pode ser escrito em qualquer linguagem, embora aqui nos utilizemos mais Python. O escopo do teste se baseia em abrir o site da amazon, pesquisar por iphone, pegar os resultados da primeira pagina (nome e preco) e criar uma planilha Excel com esses dados. ' \n");
	printf("\n\n	1. Abrir o site da Amazon e pesquisar por iphone");
	printf("\n\n	2. Pegar os resultados da primeira pagina (nome e preco) e criar uma planilha Excel com esses dados.\n");
	printf("\n\n\n	...ok, entao vamos la...buscando os resultados na Amazon...\n");
	system("python searchresults.py");
	printf("\n\n	Os resultados da busca por iPhone na Amazon foram salvos no formato JSONL.\n");
	printf("	Iniciando conversao do JSONL para CSV...\n");
	system("python converterJSONLparaCSV.py");
	printf("	Conversao do CSV para Excel\n");
	system("copy data_file.csv C:\\Users\\Public");
	system("copy leitorCSV.bas C:\\Users\\Public");
	system("cscript //nologo criadorXLSM.VBS");
	system("cd C:\\Users\\Public");
	system("del C:\\Users\\Public\\data_file.csv");
	system("del C:\\Users\\Public\\leitorCSV.bas");
	printf("	O seu arquivo foi salvo em C:\\Users\\Public \n");
	printf("FIM DO PROGRAMA");
	return 0;
}
