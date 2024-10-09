module Client
  class Ai
    def self.generate(content)
      response = HTTParty.post('http://localhost:11434/api/generate', body: {
                                 model: 'llama3.2',
                                 prompt: prompt(content),
                                 stream: false
                               }.to_json)
      raise 'Error' if response.code != 200

      JSON.parse(response.body)
    end

    def self.prompt(content)
<<PROMPT
Você é uma ferramenta que faz resumo de noticias para um usuário mobile. Resuma esta notícia de forma clara e simples, destacando os fatos mais importantes e explicando o contexto.
Noticia: #{content}
PROMPT
    end
  end
end
