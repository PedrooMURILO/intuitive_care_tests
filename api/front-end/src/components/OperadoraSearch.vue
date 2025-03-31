<template>
  <div class="container">
    <h2>Busca de Operadoras</h2>
    <div class="search-box">
      <input v-model="query" placeholder="Digite a palavra-chave" />
      <button @click="buscarOperadoras">Buscar</button>
    </div>

    <ul v-if="resultados.length">
      <li v-for="(item, index) in resultados" :key="index">
        <strong>{{ item.Razao_Social }}</strong
        ><br />
        <em>{{ item.Nome_Fantasia || 'Sem nome fantasia' }}</em
        ><br />
        <p><strong>Telefone:</strong> {{ item.Telefone }}</p>
        <p><strong>Representante:</strong> {{ item.Representante }}</p>
        <p><strong>Data de Registro:</strong> {{ item.Data_Registro_ANS }}</p>
      </li>
    </ul>

    <p v-if="!resultados.length && query">Nenhum resultado encontrado.</p>
  </div>
</template>

<script>
import axios from 'axios'

export default {
  data() {
    return {
      query: '',
      resultados: [],
    }
  },
  methods: {
    async buscarOperadoras() {
      if (this.query.trim().length === 0) {
        this.resultados = []
        return
      }

      try {
        const response = await axios.get(`http://localhost:5000/buscar?query=${this.query}`)
        this.resultados = response.data
      } catch (error) {
        console.error('Erro ao buscar operadoras:', error)
      }
    },
  },
}
</script>

<style scoped>
.container {
  text-align: center;
  margin-top: 50px;
}

.search-box {
  display: flex;
  justify-content: center;
  gap: 10px;
  margin-bottom: 20px;
}

input {
  padding: 10px;
  font-size: 16px;
  width: 250px;
}

button {
  padding: 10px 15px;
  font-size: 16px;
  background-color: #4caf50;
  color: white;
  border: none;
  cursor: pointer;
  border-radius: 5px;
}

button:hover {
  background-color: #45a049;
}

ul {
  list-style-type: none;
  padding: 0;
}

li {
  background: #f4f4f4;
  margin: 10px 0;
  padding: 10px;
  border-radius: 5px;
  text-align: left;
  max-width: 500px;
  margin-left: auto;
  margin-right: auto;
}

strong {
  font-size: 18px;
  color: #333;
}
</style>
