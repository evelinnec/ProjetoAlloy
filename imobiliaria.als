module imobiliaria

----------------------------Assinaturas----------------------------


sig Gerente {
	supervisiona: one Subgerente
}

sig Vendedor{
	vende: #Imovel = 3 
}

sig Subgerente extends Gerente{
	fiscaliza: #Vendedor < 4
}

sig Imovel{
	inspecao: #dias = 7
	
}
sig Vendas{

}

----------------------------Fatos----------------------------

fact  fatos {


	-- Definicao 
	all v : Vendedor | #vende = 3  
	all s :Subgerente | one s.~supervisiona
    
	-- Existe um gerente que esta ligado a um subgerente 
	some g:Gerente | one  s:Subgerente


	-- Todo nome so esta em uma pessoa
    all n:Nome, p:Pessoa, p1:Pessoa | n in p.nome and n in p1.nome => p = p1

}
fact vendedor {
	todoVendedorTemNoMaximoUmSubgerente[]

}
----------------------------Funcoes----------------------------

fun TalEmpresa[g: Gerente]: set Pessoa {
	g.~nome
}

fun reduzInspecao[i : Imovel] : Int {
	#(i.inspecao) -= 1
}


----------------------------Predicados----------------------------
pred temNoMaxUmSubgerente[s: Subgerente] {
    lone s.~fiscaliza
}

pred verificaVenda[i:Imovel] {
	#(i.inspecao) = 0
}

pred GerentePorSubgerente [g : Gerente] {
	one g.~supervisiona
}
pred todoSubgerenteTemTresVendedores[] {
    all s: Subgerente | #s.supervisiona = 3
}

pred todoImovelTemUmVendedor[] {
    all i: Imovel | one vende
}
----------------------------Asserts----------------------------


pred show[]{}
run show for 3
