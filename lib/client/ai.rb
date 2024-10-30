module Client
  class Ai
    include HTTParty
    default_timeout 180

    def self.generate(content)
      response = post('http://localhost:11434/api/generate', body: {
                                 model: 'llama3.2',
                                 prompt: prompt(content),
                                 stream: false
                               }.to_json)
      raise 'Error' if response.code != 200

      JSON.parse(response.body)
    end

    def self.prompt(content)
      sanitized_content = ActionView::Base.full_sanitizer.sanitize(content)

      <<PROMPT
Resuma esta notícia de forma clara e simples, destacando os fatos mais importantes e explicando o contexto.

Notícia: #{sanitized_content}

Resumo: [Breve síntese da notícia]
Fatos Principais: [Lista dos principais fatos da notícia]
Contexto: [Explicação breve do contexto]
Conclusão: [Resumo final em um único parágrafo]
PROMPT
    end
  end
end
