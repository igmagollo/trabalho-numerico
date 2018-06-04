#include <iostream>
#include <cstdlib>
#include <fstream>
#include <SFML/System.hpp>
#include <SFML/Window.hpp>
#include <SFML/Graphics.hpp>
#include <string>
#include <cmath>

using namespace std;

int main()
{
	string imagem;
	string csv;
	int escala;
	int qtd_pontos;
	sf::Vector2f A, B;
	int isPressed = 0;
	float ofset_y = 0;
	int point = 1; // o ponto zero é a borda
	float dist_points;
	float norma;

	int state = 1;

	cout << "Informe o caminha da imagem a partir desta pasta: ";
	cin >> imagem;

	cout << "Informe o caminha com o nome do arquivo csv que será criado a partir desta pasta: ";
	cin >> csv;

	cout << "Informe a escala, 1 para: ";
	cin >> escala;

	cout << "Informe a quantidade de pontos que irá coletar: ";
	cin >> qtd_pontos;
	float X[qtd_pontos];
	float Ycima[qtd_pontos];
	float Ybaixo[qtd_pontos];

	sf::Texture tex_imagem;
	if(!tex_imagem.loadFromFile(imagem))
	{
		cout << "Não foi possivel abrir a imagem " << imagem << "\n";
		return 0;
	}

	ofstream file;
	file.open(csv);
	file << "1," << escala << "\n";

	sf::Sprite sprite;
	sprite.setTexture(tex_imagem);
	sprite.setPosition(25,25);

	sf::CircleShape dot(2);
	dot.setFillColor(sf::Color::Red);
	dot.setPosition(10,10);
	dot.setOrigin(1,1);

	sf::RectangleShape eixo_x(sf::Vector2f(tex_imagem.getSize().x+50,1));
	eixo_x.setFillColor(sf::Color::Red);
	eixo_x.setOrigin(0,.5);

	sf::RenderWindow window(sf::VideoMode(tex_imagem.getSize().x+50,tex_imagem.getSize().y+50), "get dots");
	while (window.isOpen())
    {
        sf::Event event;
        while (window.pollEvent(event))
    	{
            if (event.type == sf::Event::Closed)
                window.close();
        }


        dot.setPosition(sf::Mouse::getPosition(window).x-5, sf::Mouse::getPosition(window).y-5);
        switch(state)
        {
        	case 1: if (sf::Keyboard::isKeyPressed(sf::Keyboard::Enter))
        	{
        		if(!isPressed)
        		{
        			A = dot.getPosition();
        			isPressed = 1;
        		}
        	}
        	else if(isPressed){ 
        		state++;
        		isPressed = 0;
        	}
        	break;

        	case 2: if (sf::Keyboard::isKeyPressed(sf::Keyboard::Enter))
        	{
        		if(!isPressed)
        		{
        			B = (dot.getPosition() - A);
        			isPressed = 1;
        		}
        	}
        	else if(isPressed) {
        		state++;
        		norma = (float)sqrt(B.x * B.x + B.y * B.y);
        		isPressed = 0;
        	}
        	break;

        	case 3: if(!isPressed) eixo_x.setPosition(0, dot.getPosition().y);
        	if (sf::Keyboard::isKeyPressed(sf::Keyboard::Enter))
        	{
        		if(!isPressed)
        		{
        			isPressed = 1;
        			ofset_y = eixo_x.getPosition().y;
        		}
        	}
        	else if(isPressed) {
        		state++;
        		isPressed = 0;
        	}
        	break;

        	case 4: if(!isPressed) dot.setPosition(sf::Mouse::getPosition(window).x-5, ofset_y);
        	if (sf::Keyboard::isKeyPressed(sf::Keyboard::Enter))
        	{
        		if(!isPressed)
        		{
        			isPressed = 1;
        			X[0] = dot.getPosition().x;
        			Ycima[0] = 0;
        			Ybaixo[0] = 0;
        		}
        	}
        	else if(isPressed) {
        		state++;
        		isPressed = 0;
        	}
        	break;

        	case 5: if(!isPressed) dot.setPosition(sf::Mouse::getPosition(window).x-5, ofset_y);
        	if (sf::Keyboard::isKeyPressed(sf::Keyboard::Enter))
        	{
        		if(!isPressed)
        		{
        			isPressed = 1;
        			X[qtd_pontos-1] = dot.getPosition().x;
        			Ycima[qtd_pontos-1] = 0;
        			Ybaixo[qtd_pontos-1] = 0;
        		}
        	}
        	else if(isPressed) {
        		state++;
        		isPressed = 0;
        		dist_points = (X[qtd_pontos-1] - X[0]) / (qtd_pontos-1);
        	}
        	break;

        	case 6: if(!isPressed) dot.setPosition(point * dist_points + X[0], sf::Mouse::getPosition(window).y-5);
        	if (sf::Keyboard::isKeyPressed(sf::Keyboard::Enter))
        	{
        		if(!isPressed)
        		{
        			isPressed = 1;
        			X[point] = dot.getPosition().x;
        			Ycima[point] = -(dot.getPosition().y - ofset_y);
        		}
        	}
        	else if(isPressed) {
        		point++;
        		if(point == (qtd_pontos - 1)) {
        			state++;
        			point = 1;
        		}
        		isPressed = 0;
        	}
        	break;

        	case 7: if(!isPressed) dot.setPosition(point * dist_points + X[0], sf::Mouse::getPosition(window).y-5);
        	if (sf::Keyboard::isKeyPressed(sf::Keyboard::Enter))
        	{
        		if(!isPressed)
        		{
        			isPressed = 1;
        			Ybaixo[point] = -(dot.getPosition().y - ofset_y);
        		}
        	}
        	else if(isPressed) {
        		point++;
        		if(point == (qtd_pontos - 1)) {
        			state++;
        			point = 1;
        		}
        		isPressed = 0;
        	}
        	break;

        	default: window.close();
        	break;
        }

        window.clear();
        window.draw(sprite);
        window.draw(dot);
        if(state >= 3)
        	window.draw(eixo_x);
        window.display();
    }

    for(int i = 0; i < qtd_pontos; i++){
    	file << X[i]/norma << "," << Ycima[i]/norma << "," << Ybaixo[i]/norma << "\n";
    }

    file.close();

    return 1;
}
