"""Configuration management for Personal Assistant"""
import os
from dataclasses import dataclass
from typing import Optional
from dotenv import load_dotenv

load_dotenv()

@dataclass
class AssistantConfig:
    openai_api_key: Optional[str] = None
    model_name: str = "gpt-4o-mini"
    temperature: float = 0.2
    max_tokens: int = 1000
    timezone: str = "UTC"

    @classmethod
    def from_env(cls) -> "AssistantConfig":
        return cls(
            openai_api_key=os.getenv("OPENAI_API_KEY"),
            model_name=os.getenv("DEFAULT_MODEL", "gpt-4o-mini"),
            temperature=float(os.getenv("TEMPERATURE", "0.2")),
            max_tokens=int(os.getenv("MAX_TOKENS", "1000")),
            timezone=os.getenv("DEFAULT_TIMEZONE", "UTC")
        )
