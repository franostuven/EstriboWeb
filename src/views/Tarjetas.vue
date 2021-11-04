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

            <DataTable ref="dt" :value="myTitulos"  class="p-datatable-sm" v-model:selection="selectedProducts" dataKey="id_titulo" 
                :paginator="true" :rows="10" :filters="filters"    
                paginatorTemplate="FirstPageLink PrevPageLink PageLinks NextPageLink LastPageLink CurrentPageReport RowsPerPageDropdown" 
                :rowsPerPageOptions="[5,10,25]"  currentPageReportTemplate="Muestra de {first} to {last} de {totalRecords} Titilos" 
                responsiveLayout="scroll">

                <template #header>
                    <div class="table-header p-d-flex p-flex-column p-flex-md-row p-jc-md-between">
                        <h5 class="p-mb-2 p-m-md-0 p-as-sm-center">Administración de Titulos</h5>
                        <span class="p-input-icon-left">
                            <i class="pi pi-search" />
                            <InputText v-model="filters['global'].value" placeholder="Busqueda..." />
                        </span>
					          </div>
                </template>

                <Column selectionMode="multiple" style="width: 3rem" :exportable="false"></Column>
                <Column field="descripcion_menu" header="Menu" :sortable="true" style="width:6rem"></Column>
                <Column field="descripcion_titulo" header="Titulo Tarjeta" :sortable="true" style="width:16rem"></Column>                
                <Column field="footer" header="Pie de Página" :sortable="true" style="width:16rem"></Column>
                <Column field="imagen_path" header="Path Imagen" :sortable="true" style="width:16rem"></Column>
                <Column :exportable="false" style="width:10rem">

                    <template #body="slotProps" >
                        <Button icon="pi pi-pencil" class="p-button-rounded p-button-success p-mr-2" @click="editProduct(slotProps.data)" />
                        <Button icon="pi pi-trash" class="p-button-rounded p-button-warning" @click="confirmDeleteProduct(slotProps.data)" />
                    </template>
                </Column>
            </DataTable>
         
        </div>

        <!-- **************************    PANTALLA DE ALTA Y MODIFICACION    *****************         -->
        <Dialog v-model:visible="productDialog" :style="{width: '450px'}" header="Editar Titulo" :modal="true" class="p-fluid">

        <!-- ACA VAN LOS DROPDOWN DELmenu , SACARLOS DE LA BASE. -->

            <div class="p-field">      
              <label for="titulos" class="p-mb-3">Titulo Tarjeta</label>

              <Dropdown v-model="titulo.id_menu" :options="menu" optionLabel="descripcion_menu" optionValue="id_menu" class="p-mb-3"
                  placeholder="Seleccione el Menú" />
            </div> 

            <div class="p-field p-mb-4 p-mt-4">
                <span class="p-float-label">
                    <InputText id="descripcion" v-model.trim="titulo.descripcion_titulo" required="true" autofocus :class="{'p-invalid': submitted && !titulo.descripcion_titulo}" />
                    <label for="descripcion"  >Descripcion del Titulo</label>
                </span>
                <small class="p-error" v-if="submitted && !titulo.descripcion_titulo">La Descripción es Requerida.</small>
            </div>

            <div class="p-field  p-mb-4">
                <span class="p-float-label">
                    <InputText id="footer" v-model.trim="titulo.footer" />
                    <label for="footer">Footer de la Tarjeta</label>
                </span>
                <small>Texto en Pie de la Tarjeta</small>

            </div>

            <div class="p-field">
                <span class="p-float-label">
                    <InputText id="orden" v-model.trim="titulo.imagen_path" autofocus />
                    <label for="orden">Ingrese el Path de la Imagen</label>
                </span>
                <small>Es la imagen que aparece al principio de la Tarjeta</small>

            </div>

            <template #footer>
                <Button label="Cancel" icon="pi pi-times" class="p-button-text" @click="hideDialog"/>
                <Button label="Save" icon="pi pi-check" class="p-button-text" @click="saveProduct" />
            </template>
        </Dialog>

        <Dialog v-model:visible="deleteProductDialog" :style="{width: '450px'}" header="Confirm" :modal="true">
            <div class="confirmation-content">
                <i class="pi pi-exclamation-triangle p-mr-3" style="font-size: 2rem" />
                <span v-if="titulo">Esta seguro que desea borrar el Titulo <b>{{titulo.descripcion_titulo}}</b>? SE ELIMINAN TAMBIEN LOS LINKS ASOCIADOS </span>
            </div>
            <template #footer>
                <Button label="No" icon="pi pi-times" class="p-button-text" @click="deleteProductDialog = false"/>
                <Button label="Si" icon="pi pi-check" class="p-button-text" @click="deleteProduct" />
            </template>
        </Dialog>

        <Dialog v-model:visible="deleteProductsDialog" :style="{width: '450px'}" header="Confirmar" :modal="true">
            <div class="confirmation-content">
                <i class="pi pi-exclamation-triangle p-mr-3" style="font-size: 2rem" />
                <span v-if="titulo">>Esta seguro que desea borrar los Titulos seleccionados?</span>
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
          //  console.log("Dentro de onMounted",logout.value)
            if(logout.value){
                router.push('/')
            }

            axios.post(url, {opcion:10})
            .then(response =>{
                myTitulos.value = response.data;       
          //  console.log('Datos de tabla: ',myTitulos.value)
            })

          
            axios.post(url, {opcion:9})
                .then(response =>{
                   menu.value = response.data;       
          //      console.log('Datos de menu: ',menu.value)
                })
          
        })

        
        const toast = useToast();
        const dt = ref();
        const menu = ref([]);
        const titulo = ref({});
        const ok = ref();
        const myTitulos = ref();
        const productDialog = ref(false);
        const deleteProductDialog = ref(false);
        const deleteProductsDialog = ref(false);
   //     const productService = ref(new ProductService());
        
        const selectedProducts = ref();

        const filters = ref({
            'global': {value: null, matchMode: FilterMatchMode.CONTAINS},
        });

        const submitted = ref(false);
      
        const openNew = () => {
            titulo.value = {};
            submitted.value = false;
            productDialog.value = true;
        };
        const hideDialog = () => {
            productDialog.value = false;
            submitted.value = false;
        };
        const saveProduct = () => {
            submitted.value = true;

			if (titulo.value.descripcion_titulo.trim()) {
                // SI EL ID ESTA CON INFO, ENTRE A ACTUALIZAR
                if (titulo.value.id_titulo) {
                    myTitulos.value[findIndexById(titulo.value.id_titulo)] = titulo.value;

                    actualizoTabla(titulo.value)

                    toast.add({severity:'success', summary: 'Successful', detail: 'Titulo Actualizado', life: 3000});
                }
                else {
                    // SI EL ID ESTA VACIO, SIGNIFICA QUE ES UN ALTA
                    // ACA ACTUALIZA LA BASE DE DATOS  LLAMAR RUTINA CON AXIOS
                    myTitulos.value.push(titulo.value);

                    insertoTabla(titulo.value)
                    toast.add({severity:'success', summary: 'Successful', detail: 'Titulo Creado', life: 3000});
                }
                productDialog.value = false;
                titulo.value = {};
            }
        };
        const editProduct = (prod) => {
            titulo.value = {...prod};
            productDialog.value = true;
        };
        const confirmDeleteProduct = (prod) => {
            titulo.value = prod;
            deleteProductDialog.value = true;
        };
        const deleteProduct = () => {
            myTitulos.value = myTitulos.value.filter(val => val.id_titulo !== titulo.value.id_titulo);
            deleteProductDialog.value = false;

            axios.post(url, {opcion:11,  id_titulo: titulo.value.id_titulo}).then(response =>{
                ok.value = response.data;
            }) 

            titulo.value = {};
            toast.add({severity:'success', summary: 'Successful', detail: 'Titulo Eliminado Logicamente', life: 3000});
        };

        const findIndexById = (id) => {
            let index = -1;
            for (let i = 0; i < myTitulos.value.length; i++) {
                if (myTitulos.value[i].id_titulo === id) {
                    index = i;
                    break;
                }
            }
            return index;
        };

        const exportCSV = () => {
            dt.value.exportCSV();
        };
        const confirmDeleteSelected = () => {
            deleteProductsDialog.value = true;
        };
        const deleteSelectedProducts = () => {
           /*  myTitulos.value = myTitulos.value.filter(val => !selectedProducts.value.includes(val)); */
            deleteProductsDialog.value = false;
            selectedProducts.value = null;
            
            toast.add({severity:'success', summary: 'Successful', detail: 'FUNCION DESHABILITADA (Titulos NO Eliminados)', life: 3000});
        };

        const actualizoTabla = ( obj ) =>{
          //  console.log("LO QUE VIENE EN EL OBJ: ",obj.value)
            axios.post(url, {opcion:12, id_menu: obj.id_menu, id_titulo: obj.id_titulo, descripcion_titulo: obj.descripcion_titulo, 
                            imagen_path: obj.imagen_path, footer: obj.footer})
                .then(response =>{
                   ok.value = response.data;       
               // console.log('Datos de titulo: ',ok.value)
                })
        }
 
        const insertoTabla = ( obj ) =>{
           
            axios.post(url, {opcion:13, id_menu: obj.id_menu, descripcion_titulo: obj.descripcion_titulo, 
                            imagen_path: obj.imagen_path, footer: obj.footer})
                .then(response =>{
                   ok.value = response.data;       
             //   console.log('Datos de titulo: ',ok.value)
                })
        }


        return { dt, myTitulos, titulo, menu, actualizoTabla, insertoTabla, productDialog, deleteProductDialog, 
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