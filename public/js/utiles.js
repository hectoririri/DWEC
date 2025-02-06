$(document).ready(function () {
    // Cargamos la tabla en formato datatable
    // Ajax para cargar la tabla
    $.ajax({
        url: 'php/cargarVehiculos.php',
        type: 'POST',
        success: function (respuesta) {
            console.log(respuesta);
            let tabla = $('#tabla_vehiculos');
            let thead = $('<thead></thead>');
            let tr = $('<tr></tr>');
            for (const key in respuesta[0]) {
                tr.append($('<th></th>').text(key).css('text-align', 'center'));
            }
            tr.append($('<th></th>').text("Eliminar"));
            tabla.append(thead.append(tr));

            let tbody = $('<tbody></tbody>');
            respuesta.forEach(element => {
                let tr = $('<tr></tr>');
                for (const key in element) {
                    let td = $('<td></td>').text(element[key]);
                    tr.append(td);
                }
                tbody.append(tr);
            });
            let td = $('<td></td>').append($('<button></button>').text('Eliminar').addClass('btn btn-warning').attr('data-id', element.id));
            tr.append(td);
            tbody.append(tr);
            tabla.append(tbody);
            tabla.DataTable();
        }
    });
});