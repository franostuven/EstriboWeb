<template>
    <div>
        <Toast />
        <div class="card">
            <Toolbar class="p-mb-4">
                <template #left>
                    <Button label="Nuevo" icon="pi pi-plus" class="p-button-success p-mr-2" @click="openNew" />
                    <Button label="Borrar Marcados" icon="pi pi-trash" class="p-button-danger" @click="confirmDeleteSelected" :disabled="!selectedProducts || !selectedProducts.length" />
                </template>

                <template #right>
                   <!-- <FileUpload mode="basic" accept="image/*" :maxFileSize="1000000" label="Importar" chooseLabel="Import" class="p-mr-2 p-d-inline-block" /> -->
                    <Button label="Exportar" icon="pi pi-upload" class="p-button-help" @click="exportCSV($event)"  />
                </template>
            </Toolbar>

            <DataTable ref="dt" :value="myLinks"  class="p-datatable-sm" v-model:selection="selectedProducts" dataKey="id_titulo" 
                :paginator="true" :rows="10" :filters="filters"  showGridlines   
                paginatorTemplate="FirstPageLink PrevPageLink PageLinks NextPageLink LastPageLink CurrentPageReport RowsPerPageDropdown" 
                :rowsPerPageOptions="[5,10,25]"  currentPageReportTemplate="Muestra de {first} to {last} de {totalRecords} Links" 
                responsiveLayout="scroll">
                <template #header>
                    <div class="table-header p-d-flex p-flex-column p-flex-md-row p-jc-md-between">
						<h5 class="p-mb-2 p-m-md-0 p-as-sm-center">Administración de Links</h5>
						<span class="p-input-icon-left">
                            <i class="pi pi-search" />
                            <InputText v-model="filters['global'].value" placeholder="Busqueda..." />
                        </span>
					</div>
                </template>

                <Column selectionMode="multiple" style="width: 3rem" :exportable="false"></Column>
                <Column field="descripcion_menu" header="Menu" footer="Menu" :sortable="true" style="width:6rem"></Column>
                <Column field="descripcion_titulo" header="Titulo Tarjeta" footer="Titulo Tarjeta"  :sortable="true" style="width:6rem"></Column>                
                <Column field="id_link" header="Cod." footer="Cod."  :sortable="true" style="width:3rem" ></Column>
                <Column field="descripcion_link" header="Descripción" footer="Descripción"   :sortable="true" style="width:16rem"></Column>
                <Column field="orden" header="Ord" footer="Ord"  :sortable="true" style="width:3rem"></Column>
                <Column field="path1" header="Link" footer="Link"   :sortable="true" style="width:16rem"></Column>
                <Column :exportable="false" style="width:10rem">

                    <template #body="slotProps" >
                        <Button icon="pi pi-pencil" class="p-button-rounded p-button-success p-mr-2" @click="editProduct(slotProps.data)" />
                        <Button icon="pi pi-trash" class="p-button-rounded p-button-warning" @click="confirmDeleteProduct(slotProps.data)" />
                    </template>
                </Column>
            </DataTable>
         
        </div>

        <!-- **************************    PANTALLA DE ALTA Y MODIFICACION    *****************         -->
        <Dialog v-model:visible="productDialog" :style="{width: '450px'}" header="Editar de Link" :modal="true" class="p-fluid">

        <!-- ACA VAN LOS DROPDOWN DE LOS TITULOS, SACARLOS DE LA BASE. -->

            <div class="p-field">      
				<label for="titulos" class="p-mb-3">Titulo Tarjeta</label>

                <Dropdown v-model="link.id_menu" :options="menu" optionLabel="descripcion_menu" optionValue="id_menu" class="p-mb-3"
                    placeholder="Seleccione el Menú" />

                <Dropdown v-model="link.id_titulo" :options="titulo" optionLabel="descripcion_titulo" optionValue="id_titulo" class="p-mb-3"
                    placeholder="Seleccione Titulo" />

			</div> 


            <div class="p-field p-mb-4 p-mt-4">
                <span class="p-float-label">
                    <InputText id="descripcion" v-model.trim="link.descripcion_link" required="true" autofocus :class="{'p-invalid': submitted && !link.descripcion_link}" />
                    <label for="descripcion"  >Descripcion del Link</label>
                </span>
                <small class="p-error" v-if="submitted && !link.descripcion_link">La Descripción es Requerida.</small>
            </div>

            <div class="p-field  p-mb-4">
                <span class="p-float-label">
                    <InputText id="link" v-model.trim="link.path1" required="true" autofocus :class="{'p-invalid': submitted && !link.path1}" />
                    <label for="link">Link completo</label>
                </span>
                <small class="p-error" v-if="submitted && !link.path1">El Path / Link es Requerido.</small>

            </div>

            <div class="p-field">
                <span class="p-float-label">
                    <InputText id="orden" v-model.trim="link.orden" required="true" autofocus :class="{'p-invalid': submitted && !link.orden}" />
                    <label for="orden">Ingrese el Orden de Aparicion</label>
                </span>
                <small class="p-error" v-if="submitted && !link.path1">El N° de Orden es Requerido.</small>

            </div>

            <template #footer>
                <Button label="Cancel" icon="pi pi-times" class="p-button-text" @click="hideDialog"/>
                <Button label="Save" icon="pi pi-check" class="p-button-text" @click="saveProduct" />
            </template>
        </Dialog>

        <Dialog v-model:visible="deleteProductDialog" :style="{width: '450px'}" header="Confirm" :modal="true">
            <div class="confirmation-content">
                <i class="pi pi-exclamation-triangle p-mr-3" style="font-size: 2rem" />
                <span v-if="link">Esta seguro que desea borrar el Link <b>{{link.descripcion_link}}</b>?</span>
            </div>
            <template #footer>
                <Button label="No" icon="pi pi-times" class="p-button-text" @click="deleteProductDialog = false"/>
                <Button label="Si" icon="pi pi-check" class="p-button-text" @click="deleteProduct" />
            </template>
        </Dialog>

        <Dialog v-model:visible="deleteProductsDialog" :style="{width: '450px'}" header="Confirmar" :modal="true">
            <div class="confirmation-content">
                <i class="pi pi-exclamation-triangle p-mr-3" style="font-size: 2rem" />
                <span v-if="link">>Esta seguro que desea borrar los Links seleccionados?</span>
            </div>
            <template #footer>
                <Button label="No" icon="pi pi-times" class="p-button-text" @click="deleteProductsDialog = false"/>
                <Button label="Si" icon="pi pi-check" class="p-button-text" @click="deleteSelectedProducts" />
            </template>
        </Dialog>
	</div>
</template>

<script>
import { ref, onMounted, inject } from 'vue';
import { FilterMatchMode } from 'primevue/api';
import { useToast } from 'primevue/usetoast';
import {useRouter} from 'vue-router'


//let url = "src/libreries/crud.php";
//let url ="http://localhost/estribo/src/libreries/crud.php" // DESARROLLO
let url = "crud.php";   // PRODUCCION

export default {
    setup() {

         onMounted(() => {

            const router = useRouter()

            const logout = inject('logout')

            if(logout.value){
                router.push('/')
                return
            }

            axios.post(url, {opcion:8})
            .then(response =>{
                myLinks.value = response.data;       
        //    console.log('Datos de tabla: ',myLinks.value)
            })

          
            axios.post(url, {opcion:9})
                .then(response =>{
                   menu.value = response.data;       
          //      console.log('Datos de menu: ',menu.value)
                })
         
          
            axios.post(url, {opcion:10})
                .then(response =>{
                   titulo.value = response.data;       
           //     console.log('Datos de titulo: ',menu.value)
                })
           
        })

        const toast = useToast();
        const dt = ref();
        const menu = ref([]);
        const titulo = ref([]);
        const ok = ref();
        const myLinks = ref();
        const productDialog = ref(false);
        const deleteProductDialog = ref(false);
        const deleteProductsDialog = ref(false);
        const link = ref({});
   //     const productService = ref(new ProductService());
        
        const selectedProducts = ref();

        const filters = ref({
            'global': {value: null, matchMode: FilterMatchMode.CONTAINS},
        });

        const submitted = ref(false);
    
/* 
        const formatCurrency = (value) => {
            if(value)
				return value.toLocaleString('en-US', {style: 'currency', currency: 'USD'});
			return;
        }; */

   
        const openNew = () => {
            link.value = {};
            submitted.value = false;
            productDialog.value = true;
        };
        const hideDialog = () => {
            productDialog.value = false;
            submitted.value = false;
        };
        const saveProduct = () => {
            submitted.value = true;

			if (link.value.descripcion_link.trim()) {
                // SI EL ID ESTA CON INFO, ENTRE A ACTUALIZAR
                if (link.value.id_link) {
                    myLinks.value[findIndexById(link.value.id_link)] = link.value;

                    actualizoTabla(link.value)

                    toast.add({severity:'success', summary: 'Successful', detail: 'Link Actualizado', life: 3000});
                }
                else {
                    // SI EL ID ESTA VACIO, SIGNIFICA QUE ES UN ALTA
                    // ACA ACTUALIZA LA BASE DE DATOS  LLAMAR RUTINA CON AXIOS
                    myLinks.value.push(link.value);

                    insertoTabla(link.value)
                    toast.add({severity:'success', summary: 'Successful', detail: 'Link Creado', life: 3000});
                }

                productDialog.value = false;
                link.value = {};
            }
        };
        const editProduct = (prod) => {
            link.value = {...prod};
            productDialog.value = true;
        };
        const confirmDeleteProduct = (prod) => {
            link.value = prod;
            deleteProductDialog.value = true;
        };
        const deleteProduct = () => {
            myLinks.value = myLinks.value.filter(val => val.id_link !== link.value.id_link);
            deleteProductDialog.value = false;

            axios.post(url, {opcion:3,  id_link: link.value.id_link}).then(response =>{
                ok.value = response.data;
            }) 

            link.value = {};
            toast.add({severity:'success', summary: 'Successful', detail: 'Link Eliminado Logicamente', life: 3000});

        };

        const findIndexById = (id) => {
            let index = -1;
            for (let i = 0; i < myLinks.value.length; i++) {
                if (myLinks.value[i].id_link === id) {
                    index = i;
                    break;
                }
            }

            return index;
        };
      /*   const createId = () => {
            let id = '';
            var chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
            for ( var i = 0; i < 5; i++ ) {
                id += chars.charAt(Math.floor(Math.random() * chars.length));
            }
            return id;

        } */


        const exportCSV = () => {
            dt.value.exportCSV();
        };
        const confirmDeleteSelected = () => {
            deleteProductsDialog.value = true;
        };
        const deleteSelectedProducts = () => {
           /*  myLinks.value = myLinks.value.filter(val => !selectedProducts.value.includes(val)); */
            deleteProductsDialog.value = false;
            selectedProducts.value = null;
            
            toast.add({severity:'success', summary: 'Successful', detail: 'FUNCION DESHABILITADA (Links NO Eliminados)', life: 3000});
        };

        const actualizoTabla = ( obj ) =>{
           // console.log("LO QUE VIENE EN EL OBJ: ",obj.value)
            axios.post(url, {opcion:2, id_link: obj.id_link, id_titulo: obj.id_titulo, descripcion_link: obj.descripcion_link, 
                            path1: obj.path1, orden: obj.orden})
                .then(response =>{
                   ok.value = response.data;       
               // console.log('Datos de titulo: ',ok.value)
                })
        }
 
        const insertoTabla = ( obj ) =>{
           
            axios.post(url, {opcion:0, id_titulo: obj.id_titulo, descripcion_link: obj.descripcion_link, 
                            path1: obj.path1, orden: obj.orden})
                .then(response =>{
                   ok.value = response.data;       
               // console.log('Datos de titulo: ',ok.value)
                })
        }


        return { dt, myLinks, titulo, link, menu, actualizoTabla, insertoTabla, productDialog, deleteProductDialog, 
                 deleteProductsDialog, selectedProducts, filters, submitted,  openNew, hideDialog, 
                 saveProduct, editProduct, confirmDeleteProduct, deleteProduct, findIndexById, 
                 exportCSV, confirmDeleteSelected, deleteSelectedProducts}
    }
}
</script>

<style lang="css" scoped>
/* 
.table-header {
    display: flex;
    align-items: center;
    justify-content: space-between;

    @media screen and (max-width: 960px) {
        align-items: start;
	}
} */

.product-image {
    width: 50px;
    box-shadow: 0 3px 6px rgba(0, 0, 0, 0.16), 0 3px 6px rgba(0, 0, 0, 0.23);
}

.p-dialog .product-image {
    width: 50px;
    margin: 0 auto 2rem auto;
    display: block;
}

.confirmation-content {
    display: flex;
    align-items: center;
    justify-content: center;
}
/* @media screen and (max-width: 960px) {
	::v-deep(.p-toolbar) {
		flex-wrap: wrap;
        
		.p-button {
            margin-bottom: 0.25rem;
        }
	}
} */
</style>