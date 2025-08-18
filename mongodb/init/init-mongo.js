db = connect("mongodb://localhost:27017/techsoft_analytics");

db.createCollection("produtos");
db.createCollection("sensores");

db.produtos.insertMany([
    {
        "produto_id": "TECH001",
        "nome": "TechSoft Pro 1",
        "categoria": "Software",
        "imagem": {
            "filename": "produto_001.jpg",
            "features_ml": {
                "brightness": 0.75,
                "contrast": 0.60,
                "color_histogram": {"red": [], "green": [], "blue": []}
            }
        },
        "analytics": {
            "brightness_score": 0.8,
            "color_dominance": "red"
        }
    },
    {
        "produto_id": "TECH002",
        "nome": "TechSoft Pro 2",
        "categoria": "Consultoria",
        "imagem": {
            "filename": "produto_002.jpg",
            "features_ml": {
                "brightness": 0.65,
                "contrast": 0.55,
                "color_histogram": {"red": [], "green": [], "blue": []}
            }
        },
        "analytics": {
            "brightness_score": 0.7,
            "color_dominance": "blue"
        }
    }
]);

db.sensores.insertMany([
    {
        "sensor_id": "SENSOR_001",
        "location": "sala_01",
        "audio_features": {
            "volume_db": -15.5,
            "mfcc_coefficients": [],
            "mfcc_stats": {"mean": 0, "max": 0, "min": 0}
        }
    },
    {
        "sensor_id": "SENSOR_002",
        "location": "sala_02",
        "audio_features": {
            "volume_db": -12.0,
            "mfcc_coefficients": [],
            "mfcc_stats": {"mean": 0, "max": 0, "min": 0}
        }
    }
]);