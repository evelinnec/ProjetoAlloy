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

fact  FatosGerais {
	all v : Vendedor | #vende = 3  
	all s :Subgerente | one s.~supervisiona
    
	-- Existe um gerente que esta ligado a um subgerente 
	some g:Gerente | one  s:Subgerente

}

-- todo subgerente esta ligado a um gerente
fact {
	all s: Subgerente | one s.~supervisiona
}

-- cada imovel esta ligado a um vendedor:
fact {
	all i: Imovel | one i.~vende
}
----------------------------Funcoes----------------------------

fun reduzInspecao[i : Imovel] : Int {
	#(i.inspecao) -= 1
}

fun getSubgerente[v: Vendedor] : set Subgerente {
	v.fiscaliza
}

fun getImovel[v: Vendedor] : set  Imovel {
	v.vende
}
fun getGerente[s: Subgerente]: set Gerente {
    s.supervisiona
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

assert temGerente{
    some g: Gerente | #getGerente[g] > 0
}

assert todoSubgerenteTemGerente {
	all s: Subgerente | #getGerente[s]  > 0
}

assert todoVendedorTemUmSubgerente {
    all v: Vendedor | #getSubgerente[v] > 0
}

assert todoImovelTemUmVendedor {
	all v:Vendedor | #getImovel[v]  > 0
}

check todoSubgerenteTemGerente 
check todoImovelTemUmVendedor 
check todoVendedorTemUmSubgerente
check temGerente

pred show[]{}
run show for 3
