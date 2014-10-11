function initmap(points) {
	// set up the map
	map = new L.Map('map');

	// create the tile layer with correct attribution
	var osmUrl='http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png';
	var osmAttrib='Map data © <a href="http://openstreetmap.org">OpenStreetMap</a> contributors';
	var osm = new L.TileLayer(osmUrl, {minZoom: 2, maxZoom: 32, attribution: osmAttrib});		

	// start the map in Lautere
    map.setView(points[0], 13);
	map.addLayer(osm);
    
    var polyline = L.polyline(
    points
    ).addTo(map);
    map.fitBounds(polyline.getBounds());
    
}

function initmapChange(points) {
	// set up the map
	map = new L.Map('map');

	// create the tile layer with correct attribution
	var osmUrl='http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png';
	var osmAttrib='Map data © <a href="http://openstreetmap.org">OpenStreetMap</a> contributors';
	var osm = new L.TileLayer(osmUrl, {minZoom: 2, maxZoom: 32, attribution: osmAttrib});		

	// start the map in Lautere
    map.setView(points[0], 13);
	map.addLayer(osm);
    
    var polyline = L.Polyline.PolylineEditor(
    points, {maxMarkers: 1000}
    ).addTo(map);
    map.fitBounds(polyline.getBounds());
    
}
