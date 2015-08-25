/*
     |      | _)  |    |   _)
     __ \   |  |  __|  __|  |  __ \    _` |
     |   |  |  |  |    |    |  |   |  (   |
    _.__/  _| _| \__| \__| _| _|  _| \__, |
                                     |___/
    Blitting, http://blitting.com
    Copyright (c) 2014 Jason Sturges, http://jasonsturges.com
*/
package;

import openfl.display.BitmapData;
import openfl.display.StageAlign;
import openfl.display.StageScaleMode;

import away3d.entities.Mesh;
import away3d.extrusions.Elevation;
import away3d.lights.DirectionalLight;
import away3d.materials.lightpickers.StaticLightPicker;
import away3d.materials.methods.EnvMapMethod;
import away3d.materials.methods.FogMethod;
import away3d.materials.methods.FresnelSpecularMethod;
import away3d.materials.methods.SimpleWaterNormalMethod;
import away3d.materials.TextureMaterial;
import away3d.primitives.PlaneGeometry;
import away3d.primitives.SkyBox;
import away3d.textures.BitmapCubeTexture;
import away3d.textures.BitmapTexture;
import away3d.utils.Cast;


class Main extends Away3dFirstPersonViewport {

    private var cubeTexture:BitmapCubeTexture;
    private var terrain:Elevation;
    private var terrainMaterial:TextureMaterial;
    private var waterMethod:SimpleWaterNormalMethod;
    private var waterMaterial:TextureMaterial;
    private var fresnelMethod:FresnelSpecularMethod;
    private var plane:Mesh;
    private var sunLight:DirectionalLight;
    private var lightPicker:StaticLightPicker;
    private var fogMethod:FogMethod;

    public function new() {
        super();

        stage.scaleMode = StageScaleMode.NO_SCALE;
        stage.align = StageAlign.TOP_LEFT;
    }

    override public function initializeCamera():Void {
        super.initializeCamera();

        camera.lens.far = 14000.0;
        camera.lens.near = .05;
    }

    override public function initializeLights():Void {
        super.initializeLights();

        sunLight = new DirectionalLight(-300, -300, -5000);
        sunLight.color = 0xfffdc5;
        sunLight.ambient = 1;
        scene.addChild(sunLight);

        lightPicker = new StaticLightPicker([ sunLight ]);

        fogMethod = new FogMethod(0, 8000, 0xcfd9de);
    }

    override public function initializeMaterials():Void {
        super.initializeMaterials();

        cubeTexture = new BitmapCubeTexture(
            Cast.bitmapData("assets/skybox/space/space_posX.jpg"),
            Cast.bitmapData("assets/skybox/space/space_negX.jpg"),
            Cast.bitmapData("assets/skybox/space/space_posY.jpg"),
            Cast.bitmapData("assets/skybox/space/space_negY.jpg"),
            Cast.bitmapData("assets/skybox/space/space_posZ.jpg"),
            Cast.bitmapData("assets/skybox/space/space_negZ.jpg"));

        terrainMaterial = new TextureMaterial(Cast.bitmapTexture("assets/terrain/terrain-heightmap.png"));
        terrainMaterial.lightPicker = lightPicker;
        terrainMaterial.ambientColor = 0x303040;
        terrainMaterial.ambient = 1;
        terrainMaterial.specular = .2;
        terrainMaterial.addMethod(fogMethod);

        waterMethod = new SimpleWaterNormalMethod(Cast.bitmapTexture("assets/water/water_normals.jpg"), Cast.bitmapTexture("assets/water/water_normals.jpg"));
        fresnelMethod = new FresnelSpecularMethod();
        fresnelMethod.normalReflectance = .3;

        waterMaterial = new TextureMaterial(new BitmapTexture(new BitmapData(512, 512, true, 0xaa404070)));
        waterMaterial.alphaBlending = true;
        waterMaterial.lightPicker = lightPicker;
        waterMaterial.repeat = true;
        waterMaterial.normalMethod = waterMethod;
        waterMaterial.addMethod(new EnvMapMethod(cubeTexture));
        waterMaterial.specularMethod = fresnelMethod;
        waterMaterial.gloss = 100;
        waterMaterial.specular = 1;
    }

    override public function initializeObjects():Void {
        super.initializeObjects();

        scene.addChild(new SkyBox(cubeTexture));

        terrain = new Elevation(terrainMaterial, Cast.bitmapData("assets/terrain/terrain-heightmap.png"), 5000, 1300, 5000, 250, 250);
        scene.addChild(terrain);

        plane = new Mesh(new PlaneGeometry(5000, 5000), waterMaterial);
        plane.geometry.scaleUV(50, 50);
        plane.y = 5;
        scene.addChild(plane);
    }

    override public function prerender():Void {
        super.prerender();

        waterMethod.water1OffsetX += .001;
        waterMethod.water1OffsetY += .001;
        waterMethod.water2OffsetX += .0007;
        waterMethod.water2OffsetY += .0006;

        camera.y += 0.2 * (terrain.getHeightAt(camera.x, camera.z) + 20 - camera.y);
    }

}