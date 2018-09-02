#ifndef TEXTFIELD_HXX_
#define TEXTFIELD_HXX_

#include "uiElement.hxx"
#include "text.hxx"

class TextField : public UiElement
{
public:
  TextField() = default;
  TextField(const SDL_Rect &uiElementRect) : UiElement(uiElementRect), _textFieldRect(uiElementRect) {}

  ~TextField() override = default;

  void addText(std::string text);

  void draw() override;

private:
  std::map<int, Text*> _textList;
  SDL_Rect _textFieldRect;
};

#endif