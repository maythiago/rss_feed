module Client
  class Ai
    include HTTParty
    default_timeout 180

    def self.generate(content)
      response = post("http://ollama:11434/api/generate", body: {
                                 model: "llama3.2",
                                 prompt: prompt(content),
                                 format: "json",
                                 stream: false
                               }.to_json)
      raise response.body if response.code != 200

      JSON.parse(response.body)
    end

    def self.prompt(content)
      sanitized_content = ActionView::Base.full_sanitizer.sanitize(content)

      <<PROMPT
Resuma a seguinte noticia organizando as informações em quatro seções, que devem ter coerencia entre si e serem apresentadas de forma clara e objetiva:


1. Resumo: Apresente uma síntese breve e direta do conteúdo, destacando o tema principal e sua relevância.
2. Principais Fatos: Liste os fatos mais importantes, detalhando os eventos e ações relevantes, com explicações adicionais sobre seu impacto ou significado.
3. Contexto: Forneça informações detalhadas sobre o ambiente ou circunstâncias que ajudaram a moldar os eventos relatados, destacando o cenário histórico ou atual relacionado.
4. Conclusão: Explique as principais conclusões ou desfechos, considerando as implicações e possíveis desdobramentos futuros.

Mantenha um tom amigavel e profissional, e garanta que o resumo seja acessível a um público geral, sem omitir informações relevantes, nem adicionar informações novas.
Escreva a resposta em português, utilizando frases completas e coesas, e evite repetições ou redundâncias.

Notícia: #{sanitized_content}

Retorne as informações acima no formato json:
- summary: string
- principal_facts: string[]
- context: string
- conclusion: string

Exemplo de saída:
{
  "summary": "Resumo",
  "principal_facts": ["Principal fato 1", "Principal fato 2"],
  "context": "Contexto",
  "conclusion": "Conclusão"
}
PROMPT
    end
  end
end
